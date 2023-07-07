//
//  CharacterDetailView.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 06.07.2023.
//

import SwiftUI



struct CharacterDetailView: View {
    
    @State var character: Character
    
//    @State var isFavourite: Bool
    
    @Binding var model: CharactersModel

    var pairsOfInfo: KeyValuePairs<String, String>
    
    init(character: Character, model: Binding<CharactersModel>) {
//        self._isFavourite = State(wrappedValue: character.isFavourite)
        self._character = State(wrappedValue: character)
        self._model = model
        pairsOfInfo = [
            "Status": character.apiResult.status ?? "unavailable",
            "Species": character.apiResult.species ?? "unavailable",
            "Type": character.apiResult.type ?? "unavailable",
            "Gender": character.apiResult.gender ?? "unavailable",
            "Origin": character.apiResult.origin?.name ?? "unavailable",
            "Location": character.apiResult.location?.name ?? "unavailable"]
    }
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    Color.itemColor
                        .frame(height: 450)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                    VStack {
                        HStack(alignment: .top, spacing: 25) {
                            if let img = character.apiResult.image {
                                AsyncImage(url: img,
                                           content: { image in
                                               image.resizable()
                                                   .cornerRadius(5)
                                           },
                                           placeholder: {
                                               ProgressView()
                                           })
                                    .scaledToFit()
                                    .frame(height: 175)
                            }
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Name")
                                    .foregroundColor(.gray)
                                Text(character.apiResult.name ?? "unavailable")
                                    .bold()
                            }
                            .padding(.vertical)
                            favouriteIcon()
                                .padding(.vertical)
                        }
                        .padding(.horizontal)
                        Divider()
                        HStack(spacing: 50) {
                            VStack (alignment: .leading, spacing: 20) {
                                ForEach(pairsOfInfo, id: \.key) { key, _ in
                                    Text(key)
                                        .frame(height: 20)
                                }
                            }
                            .foregroundColor(.gray)
                            VStack (alignment: .leading, spacing: 20) {
                                    ForEach(pairsOfInfo, id: \.key) { _, value in
                                    Text(value)
                                        .frame(height: 20)
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
    //                    .fixedSize(horizontal: false, vertical: true)
//                        .padding()
    //                    Spacer()
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder func favouriteIcon() -> some View {
        if character.isFavourite {
            Image(systemName: "star.fill")
                .foregroundColor(.blue)
//                .background(.blue)
                .font(.system(size: 30))
                .scaledToFit()
                .onTapGesture {
                    model.toggleFavourite(character: self.character)
                    character.isFavourite.toggle()
                }
        }
        else {
            Image(systemName: "star")
                .foregroundColor(.gray)
                .font(.system(size: 30))
                .scaledToFit()
                .onTapGesture {
                    model.toggleFavourite(character: self.character)
                    character.isFavourite.toggle()
                }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var model = CharactersModel()
        CharacterDetailView(character: Character.mock, model: $model)
    }
}
