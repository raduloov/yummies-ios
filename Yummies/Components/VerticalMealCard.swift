//
//  MealCard.swift
//  Yummies
//
//  Created by Yavor Radulov on 26.07.22.
//

import SwiftUI

struct VerticalMealCard: View {
    
    let uri: String
    let imageUrl: String
    let label: String
    let nutrients: TotalNutrients
    
    var body: some View {
        NavigationLink {
            // Extract recipe ID from URI
            let recipeID = String(self.uri.suffix(32))
            RecipeDetailsView(recipeID: recipeID)
                .toolbar(.hidden)
        } label: {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.5))
                    
                    Text(label)
                        .foregroundColor(Color.black)
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.vertical)
                }
                .frame(width: 300)
                
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.gray.opacity(0.2))
                        LoadingIndicator()
                    }
                }
                .frame(width: 300, height: 200)
                .cornerRadius(15)
                .shadow(radius: 5, x: 0, y: 5)
                
                NutrientStickers(nutrients: [
                    Nutrient(color: "kcalSticker", label: "KCal", quantity: String(Int(nutrients.kcals.quantity)), units: "kcal"),
                    Nutrient(color: "proteinSticker", label: "Protein", quantity: String(Int(nutrients.protein.quantity)), units: "g"),
                    Nutrient(color: "carbsSticker", label: "Carbs", quantity: String(Int(nutrients.carbs.quantity)), units: "g"),
                    Nutrient(color: "sugarSticker", label: "Sugars", quantity: String(Int(nutrients.sugars.quantity)), units: "g"),
                    Nutrient(color: "satFatSticker", label: "Sat. Fat", quantity: String(Int(nutrients.satFat.quantity)), units: "g"),
                    Nutrient(color: "fiberSticker", label: "Fiber", quantity: String(Int(nutrients.fiber.quantity)), units: "g")
                ])
            }
            .padding(.bottom, 40)
        }
    }
}

//struct MealCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MealCard()
//    }
//}
