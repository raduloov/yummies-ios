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
    let nutrients: TotalNutrientsDTO
    let userID: String
    
    @EnvironmentObject private var mealCardVM: MealCardViewModel
    
    var body: some View {
        NavigationLink {
            let recipeID = mealCardVM.getRecipeID(from: uri)
            
            RecipeDetailsView(recipeID: recipeID, userID: userID)
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
                    Nutrient(color: Color("kcalSticker"), label: "KCal", quantity: Int(nutrients.kcals.quantity), units: "kcal"),
                    Nutrient(color: Color("proteinSticker"), label: "Protein", quantity: Int(nutrients.protein.quantity), units: "g"),
                    Nutrient(color: Color("carbsSticker"), label: "Carbs", quantity: Int(nutrients.carbs.quantity), units: "g"),
                    Nutrient(color: Color("sugarSticker"), label: "Sugars", quantity: Int(nutrients.sugars.quantity), units: "g"),
                    Nutrient(color: Color("satFatSticker"), label: "Sat. Fat", quantity: Int(nutrients.satFat.quantity), units: "g"),
                    Nutrient(color: Color("fiberSticker"), label: "Fiber", quantity: Int(nutrients.fiber.quantity), units: "g")
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
