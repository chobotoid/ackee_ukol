//
//  Character&FavouriteView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 30.06.2023.
//

import SwiftUI

enum ViewType {
    case loaded
    case favourite
}

/// View to show Characters list or Favourite list of characters
struct CharactersAndFavouritesView: View {
    
    ///ViewModel for the view
    @ObservedObject var vm: CharactersAndFavouritesViewModel
    
    /// search box contains
    @State var searchText = ""
    
    /// type of the view to be shown - favourite or characters
    let type: ViewType
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                if !searchResults.isEmpty {
                    searchResultCharacters
                    if searchText.isEmpty && type == .loaded {
                        moreCharactersButton
                        Spacer(minLength: 80)
                    }
                }
                else {
                    typeableText
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                }
            }
            .background(Color.primaryColor)
            .navigationTitle(type == .loaded ? "Characters" : "Favourites")
            .frame(maxWidth: .infinity)
            .searchable(text: $searchText, placement: .toolbar)
        }
        .padding()
        .background(Color.primaryColor)
        .ignoresSafeArea(.all)
    }
    
    @ViewBuilder var typeableText: some View {
        if type == .loaded {
            Text(!searchText.isEmpty ? "No results for your query" : "No characters loaded")
        }
        else {
            Text(!searchText.isEmpty ? "No results for your query" : "No favourite characters")
        }
    }
    
    @ViewBuilder var searchResultCharacters: some View {
        ForEach(searchResults, id: \.apiResult.id) { character in
            NavigationLink(destination: CharacterDetailView(character: character, model: $vm.model)){
                ZStack {
                    Color.primaryColor
                    CharacterItemView(character: character)
                }
            }
        }
    }
    
    @ViewBuilder var moreCharactersButton: some View {
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
    }
    
    var searchResults: [Character] {
        if searchText.isEmpty {
            if type == .loaded {
                return vm.model.loadedCharacters
            }
            else {
                return vm.model.favouriteCharacters
            }
        } else {
            if type == .loaded {
                return vm.model.searchLoadedCharacters(input: searchText)
            }
            else {
                return vm.model.searchFavouriteCharacters(input: searchText)
            }
        }
    }
    
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        @State var model = CharactersModel()
        let vm = CharactersAndFavouritesViewModel(model: model)
        CharactersAndFavouritesView(vm: vm, type: .loaded)
    }
}
