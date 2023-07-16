//
//  CustomTabBarItemsPreferenceKey.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 04.07.2023.
//

import SwiftUI

/// To be honest, pretty much scrambled this from a youtube video, couldn't make it on my own, but was able to understand it enough to customize it to my needs
struct CustomTabBarItemsPreferenceKey: PreferenceKey {
    
    static var defaultValue: [CustomTabBarItem] = []
    
    static func reduce(value: inout [CustomTabBarItem], nextValue: () -> [CustomTabBarItem]) {
        value += nextValue()
    }
}


struct CustomTabBarItemViewModifier: ViewModifier {
    
    let tab: CustomTabBarItem
    @Binding var selection: CustomTabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1 : 0)
            .preference(key: CustomTabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    
    func customTabItem(tab: CustomTabBarItem, selection: Binding<CustomTabBarItem>) -> some View {
        self
            .modifier(CustomTabBarItemViewModifier(tab: tab, selection: selection))
    }
}
