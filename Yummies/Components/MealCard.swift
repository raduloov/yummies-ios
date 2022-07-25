//
//  MealCard.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

import SwiftUI

struct MealCard: View {
    
    let uri: String
    let imageUrl: String
    let label: String
    let nutrients: TotalDaily
    
    var body: some View {
        NavigationLink {
            // Extract recipe ID from URI
            let recipeID = String(self.uri.suffix(32))
            RecipeDetailsView(recipeID: recipeID)
        } label: {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.5))
                    
                    Text(label)
                        .foregroundColor(Color.black)
                        .font(.system(.body, design: .rounded))
                        .frame(width: 220)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                }
                
                AsyncImage(url: URL(string: imageUrl)) { image in
                    ZStack {
                        image
                            .resizable()
                            .scaledToFill()
                    }
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.gray.opacity(0.2))
                        LoadingIndicator()
                    }
                }
                .frame(width: 220, height: 170)
                .cornerRadius(15)
                .shadow(radius: 5, x: 0, y: 5)
                
                NutrientStickers(
                    kcal: String(Int(nutrients.kcals.quantity)),
                    protein: String(Int(nutrients.protein.quantity)),
                    sugars: String(Int(nutrients.sugars.quantity))
                )
            }
        }
        .padding()
    }
}

//struct MealCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MealCard(uri: "", imageUrl: "", label: "Label")
//    }
//}
