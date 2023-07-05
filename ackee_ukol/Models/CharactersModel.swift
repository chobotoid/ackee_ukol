//
//  CharactersModel.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 05.07.2023.
//

import Foundation

struct Character {
    
    var apiResult: Result
    
    var isFavourite: Bool
    
}

class CharactersModel: ObservableObject {
    
    @Published var loadedCharacters: Array<Character>
    
    @Published var favouriteCharacters: Array<Character>
    
    init(){
        loadedCharacters = Array()
        favouriteCharacters = Array()
    }
    
    func loadCharacters(characters: Array<Result?>) {
        if let character = characters.first {
            if loadedCharacters.contains(where: {$0.apiResult.id == character?.id}) {
                return
            }
        }
        for character in characters {
            if let character {
                loadedCharacters.append(Character(apiResult: character, isFavourite: false))
            }
        }
        print("LOADING DONE")
        print(loadedCharacters.count)
    }
    
    func toggleFavourite(character: Character) {
        if let index = loadedCharacters.firstIndex(where: {$0.apiResult.name == character.apiResult.name}) {
            if loadedCharacters[index].isFavourite {
                if let favIndex = favouriteCharacters.firstIndex(where: {$0.apiResult.name == character.apiResult.name}) {
                    favouriteCharacters.remove(at: favIndex)
                }
            }
            else {
                favouriteCharacters.append(loadedCharacters[index])
            }
            loadedCharacters[index].isFavourite.toggle()
        }
    }
    
}
