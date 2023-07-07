//
//  FavouritesView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 04.07.2023.
//

import SwiftUI

struct FavouritesView: View {
    
    @ObservedObject var vm: CharactersViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryColor
                    .ignoresSafeArea(.all)
                VStack (alignment: .leading){
                    Text("Favourites")
                        .font(.title)
                        .bold()
                    ScrollView(showsIndicators: false) {
//                        Text("Search")
                        ForEach(vm.model.favouriteCharacters, id: \.apiResult.id) { character in
                            NavigationLink(destination: CharacterDetailView(character: character, model: $vm.model)){
                                ZStack {
                                    Color.primaryColor
                                    CharacterItemView(character: character)
                                }
                            }
                            .toolbar(.hidden)
                        }
                        Spacer(minLength: 50)
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        @State var model = CharactersModel()
        let vm = CharactersViewModel(model: model)
        FavouritesView(vm: vm)
    }
}
