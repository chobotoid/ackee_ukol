//
//  CharacterView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 04.07.2023.
//

import SwiftUI

struct CharacterItemView: View {
    
//    let character: Result
    let character: Character
    
    var body: some View {
        HStack{
            AsyncImage(url: character.apiResult.image,
                       content: { image in
                           image.resizable()
                               .cornerRadius(5)
                       },
                       placeholder: {
                           ProgressView()
                       })
                .scaledToFit()
                .frame(height: 50)
            VStack(alignment: .leading) {
                HStack {
                    Text(character.apiResult.name ?? "unknown name")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(Color.primaryColor)
                        .colorInvert()
                    if character.isFavourite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.blue)
                    }
                }
                Text(character.apiResult.status ?? "unknown status")
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
            
        }
        .padding(10)
        .background(Color.itemColor)
        .cornerRadius(15)
//        .shadow(radius: 1)
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterItemView(character: Character.mock)
    }
}
