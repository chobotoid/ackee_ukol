//
//  CharactersViewModel.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 04.07.2023.
//

import SwiftUI

class CharactersViewModel: ObservableObject {
    
//    @Published var response: CharactersResponse?
    
    @Published var model: CharactersModel
    
    var characters: Array<Character> {
        model.loadedCharacters
    }
    
    init(model: CharactersModel) {
        self.model = model
        Task {
            await getCharacterList(url: nil)
        }
    }
    
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
//                        if let results = tmpResponse.results {
//                        }
                        self.model.loadCharacters(characters: tmpResponse.results)
//                        self.response = tmpResponse
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
    
    func getNextPage() async {
//        if let next = response?.info?.next {
//            await getCharacterList(url: next)
//        }
//        else {
//            print("Next is nil")
//        }
    }
    
}

