//
//  RecipeDetailsView.swift
//  Yummies
//
//  Created by Yavor Radulov on 25.07.22.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    let recipeID: String
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var recipeDetailsVM = RecipeDetailViewModel()
    @State private var showAllNutrients: Bool = false
    
    var body: some View {
        ZStack {
            Color("bgGradient1")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                NavigationBar(dismiss: dismiss)
                
                if let recipeData = recipeDetailsVM.recipeData?.recipe {
                    AsyncImage(url: URL(string: recipeData.image)) { image in
                        ZStack {
                            image
                                .resizable()
                                .scaledToFit()
                        }
                    } placeholder: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.2))
                            LoadingIndicator()
                        }
                        .scaledToFit()
                    }
                    .shadow(radius: 5, x: 0, y: 5)
                    
                    VStack {
                        HStack {
                            Text(recipeData.label)
                                .font(.system(size: 30, weight: .heavy, design: .rounded))
                            
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        VStack {
                            HStack {
                                Text("Nutrition Values")
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Button(action: {
                                    showAllNutrients.toggle()
                                }) {
                                    Text("See all")
                                        .foregroundColor(Color.black.opacity(0.6))
                                }
                            }
                            
                            VStack {
                                NutrientStickersLargeRow(nutrients: [
                                    Nutrient(color: "kcalSticker", label: "KCal", quantity: String(Int(recipeData.totalNutrients.kcals.quantity)), units: "kcal"),
                                    Nutrient(color: "proteinSticker", label: "Protein", quantity: String(Int(recipeData.totalNutrients.protein.quantity)), units: "g")
                                ])
                                NutrientStickersLargeRow(nutrients: [
                                    Nutrient(color: "carbsSticker", label: "Carbs", quantity: String(Int(recipeData.totalNutrients.carbs.quantity)), units: "g"),
                                    Nutrient(color: "sugarSticker", label: "Sugars", quantity: String(Int(recipeData.totalNutrients.sugars.quantity)), units: "g")
                                ])
                                NutrientStickersLargeRow(nutrients: [
                                    Nutrient(color: "satFatSticker", label: "Sat. Fat", quantity: String(Int(recipeData.totalNutrients.satFat.quantity)), units: "g"),
                                    Nutrient(color: "fiberSticker", label: "Fiber", quantity: String(Int(recipeData.totalNutrients.fiber.quantity)), units: "g")
                                ])
                            }
                        }
                    }
                    .padding()
                    .sheet(isPresented: $showAllNutrients, content: {
                        AllNutrientsSheetView(nutrients: recipeData.totalNutrients)
                            .presentationDetents([.medium, .large])
                    })
                }
            }
        }
        .task {
            await recipeDetailsVM.populateRecipeData(recipeID: recipeID)
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipeID: "d086f51bd7ca046eac74bda9198ece46")
    }
}
