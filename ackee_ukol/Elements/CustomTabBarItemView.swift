//
//  CustomTabBarItemView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 30.06.2023.
//

import SwiftUI

struct CustomTabBarItemView: View {
    let tabs: [CustomTabBarItem]
    
    @Binding var selection: CustomTabBarItem
    
    var body: some View {
        HStack (spacing: 1){
            ForEach(tabs, id: \.self ) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .frame(width: nil, height: 60)
        .background(Color.itemColor)
//        .border(.red)
        .cornerRadius(35)
//        .padding()
    }
}

extension CustomTabBarItemView {
    private func tabView(tab: CustomTabBarItem) -> some View {
        VStack (spacing: 1){
            Image(tab.iconName)
                .font(.system(size: 50))
                .foregroundColor(selection == tab ? .blue : .gray)
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .cornerRadius(10)
                .frame(maxWidth: nil)
        }
        .padding(.vertical, 8)
    }
    
    private func switchToTab(tab: CustomTabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

struct CustomTabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [CustomTabBarItem] = [
            .characters, .favourites]
        CustomTabBarItemView(tabs: tabs, selection: .constant(tabs.first!))
    }
}
