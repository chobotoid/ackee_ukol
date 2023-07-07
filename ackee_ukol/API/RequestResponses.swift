//
//  HTTPRequest.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 04.07.2023.
//

import Foundation


//MARK: CharactersResponse
struct CharactersResponse: Decodable {
    
    var info: Info?
    
    var results: [Result?]
    
}

struct Info: Decodable {
    
    var count: Int?
    
    var pages: Int?
    
    var next: URL?
    
    var prev: URL?
    
}

struct Result: Decodable {
    
    var id: Int?
    
    var name: String?
    
    var status: String?
    
    var species: String?
    
    var type: String?
    
    var gender: String?
    
    var origin: Origin?
    
    var location: Location?
    
    var image: URL?
    
}

extension Result {
    static let mock: Result = Result(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: Origin.mock, location: Location.mock, image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
}

struct Origin: Decodable {
    
    var name: String?
    
    var url: String?
    
}

extension Origin {
    static let mock: Origin = Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1")
}

struct Location: Decodable {
    
    var name: String?
    
    var url: String?
    
}

extension Location {
    static let mock: Location = Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3")
}
