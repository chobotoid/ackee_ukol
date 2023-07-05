//
//  CharactersView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 30.06.2023.
//

import SwiftUI

struct CharactersView: View {
    
    @ObservedObject var vm: CharactersViewModel
    
//    init(model: CharactersModel) {
//        self._vm = ObservedObject(wrappedValue: CharactersViewModel(model: model))
//    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Characters")
                .font(.title)
                .bold()
            ScrollView(showsIndicators: false) {
                Text("Search")
                ForEach(vm.model.loadedCharacters, id: \.apiResult.id) { character in
                    CharacterItemView(character: character)
                }
                Spacer(minLength: 50)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        @State var model = CharactersModel()
        let vm = CharactersViewModel(model: model)
        CharactersView(vm: vm)
    }
}
