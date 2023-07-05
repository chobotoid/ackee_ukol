//
//  CustomTabBarItem.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 30.06.2023.
//

import Foundation

enum CustomTabBarItem: Hashable {
    case characters, favourites
    
    var iconName: String {
        switch self {
        case .characters: return "Character"
        case .favourites: return "Favourite"
        }
    }
    
//    var tabName: String {
//        switch self {
//        case .characters: return "Daily"
//        case .favourites: return "Launches"
//        }
//    }
}



