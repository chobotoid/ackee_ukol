//
//  ContentView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 30.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection: CustomTabBarItem = .characters
    
    @StateObject var model: CharactersModel = CharactersModel()
    
    var body: some View {
        CustomTabBarView(selection: $tabSelection) {
            CharactersView(vm: CharactersViewModel(model: model))
                .customTabItem(tab: .characters, selection: $tabSelection)
            FavouritesView(vm: CharactersViewModel(model: model))
                .customTabItem(tab: .favourites, selection: $tabSelection)
        }
//        .onTapGesture {
//            print(model.loadedCharacters.count)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
