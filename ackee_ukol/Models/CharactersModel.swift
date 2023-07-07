//
//  CharactersModel.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 05.07.2023.
//

import Foundation



/// Struct holding info about each character, wanted to change it to class so that in `CharactersModel` there aren't the characters twice, but once and second one is reference, but was unsuccessful - `CharactersView` stopped updating upon changing favourite status, which I was unable to solve
/// - SeeAlso: `CharactersModel`, `CharactersView`
struct Character {
    
    /// Result of API call, containing characters and info about them
    var apiResult: Result
    
    /// Boolean showing whether the character was favorized by user, also whether it should be found in `favouriteCharacters` or not
    var isFavourite: Bool
    
}

extension Character {
    static var mock: Character = Character(apiResult: Result.mock, isFavourite: false)
    static var mockFav: Character = Character(apiResult: Result.mock, isFavourite: true)
}

/// Model containing all info about characters to be shown in UI
class CharactersModel: ObservableObject {
    
    /// All loaded characters
    @Published var loadedCharacters: Array<Character>
    
    /// Favoritized characters out of the loaded ones
    @Published var favouriteCharacters: Array<Character>
    
    /// Info about the API call - where to get next page of characters, etc...
    var info: Info
    
    init(){
        loadedCharacters = Array()
        favouriteCharacters = Array()
        info = Info()
    }
    
    /// Function for loading Characters out of raw API call response`
    /// - Parameter characters: Array of optional API response parts to get the Character array from
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
    
    /// Function for loading info about the API situation - where to get next page of characters, etc...
    /// - Parameter info: Raw info response of API call
    func loadInfo(info: Info?) {
        if let rawInfo = info {
            self.info = rawInfo
        }
    }
    
    /// Toggles the `isFavourite` parameter either to on or off and changes the `favouriteCharacters` array accordingly
    /// - Parameter character: A certain character to use the function on, requires the character to be in `loadedCharacters` or even in `favouriteCharacters`
    func toggleFavourite(character: Character) {
        if let index = loadedCharacters.firstIndex(where: {$0.apiResult.name == character.apiResult.name}) {
            if loadedCharacters[index].isFavourite {
                if let favIndex = favouriteCharacters.firstIndex(where: {$0.apiResult.name == character.apiResult.name}) {
                    favouriteCharacters.remove(at: favIndex)
                    loadedCharacters[index].isFavourite.toggle()
                }
            }
            else {
                loadedCharacters[index].isFavourite.toggle()
                favouriteCharacters.append(loadedCharacters[index])
            }
        }
    }
    
    func searchLoadedCharacters(input: String) -> Array<Character> {
        return loadedCharacters.filter{
            if let name = $0.apiResult.name {
                return name.contains(input)
            }
            return false
        }
    }
    
}
