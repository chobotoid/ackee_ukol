//
//  CharactersView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 30.06.2023.
//

import SwiftUI

struct CharactersView: View {
    
    @ObservedObject var vm: CharactersViewModel
    
    @State var searchText = ""
    
//    init(model: CharactersModel) {
//        self._vm = ObservedObject(wrappedValue: CharactersViewModel(model: model))
//    }
    
    var body: some View {
        NavigationStack {
//                Color.primaryColor
//                    .ignoresSafeArea(.all)
                VStack (alignment: .leading){
                    Text("Characters")
                        .font(.title)
                        .bold()
                    ScrollView(showsIndicators: false) {
                        TextField("Search character", text: $searchText)
                            .padding(3)
                            .background(Color.itemColor)
                            .cornerRadius(5)
                            
                        ForEach(vm.model.loadedCharacters, id: \.apiResult.id) { character in
                            NavigationLink(destination: CharacterDetailView(character: character, model: $vm.model)){
                                ZStack {
                                    Color.primaryColor
                                    CharacterItemView(character: character)
                                }
                            }
                            .toolbar(.hidden)
                        }
                        Button("Load more characters", action: {
                            Task {
                                await vm.getNextPage()
                            }
                        })
                        .foregroundColor(.itemColor)
                        .colorInvert()
                        .padding(10)
                        .background(Color.itemColor)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        Spacer(minLength: 60)
                    }
                    .frame(maxWidth: .infinity)
            }
                .padding()
            .background(Color.primaryColor)
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        @State var model = CharactersModel()
        let vm = CharactersViewModel(model: model)
        CharactersView(vm: vm)
    }
}
