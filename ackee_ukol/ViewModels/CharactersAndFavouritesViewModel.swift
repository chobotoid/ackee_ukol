//
//  CharactersViewModel.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 04.07.2023.
//

import SwiftUI

/// ViewModel for `CharactersAndFavouritesView`
class CharactersAndFavouritesViewModel: ObservableObject {
    
    /// Model containing all the necessary data
    @Published var model: CharactersModel
    
    /// Initializer for the ViewModel
    /// - Parameter model: Model to be containing all the information needed by the ViewModel and the Views
    init(model: CharactersModel) {
        self.model = model
        Task {
            await getCharacterList(url: nil)
        }
    }
    
    /// Function either to get first page of characters or to get the next pages
    /// - Parameter url: if null - gets first page, else - gets data from the given page
    func getCharacterList(url: URL?) async {
        let tmpUrl: URL?
        if let notNilURL = url {
            tmpUrl = notNilURL
        }
        else {
            tmpUrl = URL(string: "https://rickandmortyapi.com/api/character")
        }
        guard let url = tmpUrl else{
            print("URL FAILED in \(#function)")
            return
        }
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            else if let data = data {
                do {
                    let tmpResponse = try JSONDecoder().decode(CharactersResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.model.loadCharacters(characters: tmpResponse.results)
                        self.model.loadInfo(info: tmpResponse.info)
                    }
                }
                catch {
                    print(error)
                }
            }
            else{
                print("dataTask failed in \(#function)")
            }
        }

        task.resume()
    }
    
    /// Function to load next page of characters from api
    func getNextPage() async {
        if let next = model.info.next {
            print("NEXT PAGE LOADING")
            await getCharacterList(url: next)
        }
        else {
            print("Next is nil")
        }
    }
    
    /// Function to toggle a characters favourite status
    /// - Parameter character: character to be favourited or unfavourited
    func toggleFavourite(character: Character) {
        model.toggleFavourite(character: character)
    }
    
}

