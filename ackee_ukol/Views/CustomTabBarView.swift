//
//  CustomTabBarView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 04.07.2023.
//

import SwiftUI

struct CustomTabBarView<Content:View>: View {
    
    @Binding var selection: CustomTabBarItem
    
    let content: Content
    
    @State private var tabs: [CustomTabBarItem] = []
    
    init(selection: Binding<CustomTabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack (spacing: 0) {
            ZStack {
                content
                VStack{
                    Spacer()
                    CustomTabBarItemView(tabs: tabs, selection: $selection)
                }
            }
        }
        .onPreferenceChange(CustomTabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
        .background(Color.primaryColor)
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [CustomTabBarItem] = [
            .characters,
            .favourites]
        
        CustomTabBarView(selection: .constant(tabs.first!)) {
            Color.gray
        }
    }
}
