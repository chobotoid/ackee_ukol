//
//  ContentView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 30.06.2023.
//

import SwiftUI

/// ContentView of the whole app pretty much
struct ContentView: View {
    
    @State private var tabSelection: CustomTabBarItem = .characters
    
    @StateObject var model: CharactersModel = CharactersModel()
    
    var body: some View {
        CustomTabBarView(selection: $tabSelection) {
            CharactersAndFavouritesView(vm: CharactersAndFavouritesViewModel(model: model), type: .loaded)
                .customTabItem(tab: .characters, selection: $tabSelection)
            CharactersAndFavouritesView(vm: CharactersAndFavouritesViewModel(model: model), type: .favourite)
                .customTabItem(tab: .favourites, selection: $tabSelection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
