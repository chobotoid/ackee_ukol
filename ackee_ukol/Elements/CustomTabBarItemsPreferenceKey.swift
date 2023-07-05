//
//  CustomTabBarItemsPreferenceKey.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 04.07.2023.
//

import SwiftUI

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
