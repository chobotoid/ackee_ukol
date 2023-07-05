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

struct Origin: Decodable {
    
    var name: String?
    
    var url: String?
    
}

struct Location: Decodable {
    
    var name: String?
    
    var url: String?
    
}
