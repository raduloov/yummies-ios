//
//  RecipeDetailsView.swift
//  Yummies
//
//  Created by Yavor Radulov on 25.07.22.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    let recipeID: String
    let userID: String
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var recipeDetailsVM = RecipeDetailViewModel()
    @StateObject private var hapticFeedback = HapticFeedback()
    @State private var showNutrientList: Bool = false
    @State private var showIngredientList: Bool = false
    
    var body: some View {
        
        ZStack {
            Color("bgGradient1")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                NavigationBar(dismiss: dismiss, favoriteButton: !recipeDetailsVM.fetchingError ? true : false, userID: userID, recipeID: recipeID)
                
                if recipeDetailsVM.fetchingError {
                    ErrorCard {
                        Task {
                            await recipeDetailsVM.populateRecipeData(recipeID: recipeID)
                        }
                    }
                } else if !recipeDetailsVM.recipeLoaded {
                    VStack {
                        LoadingIndicator(text: "Getting recipe info...", size: 2)
                    }
                    .frame(width: K.SCREEN_WIDTH, height: K.SCREEN_HEIGHT / 2)
                } else if let recipeData = recipeDetailsVM.recipeData?.recipe {
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
                                    showNutrientList.toggle()
                                    hapticFeedback.trigger(intensity: .medium)
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
                        .padding(.bottom)
                        
                        VStack {
                            HStack {
                                Text("Ingredients")
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Button(action: {
                                    showIngredientList.toggle()
                                    hapticFeedback.trigger(intensity: .medium)
                                }) {
                                    Text("See all")
                                        .foregroundColor(Color.black.opacity(0.6))
                                }
                            }
                            .padding(.bottom, 5)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    ForEach(recipeData.ingredientLines, id: \.self) { line in
                                        Text(line)
                                            .font(.system(.title3, design: .rounded))
                                            .padding(.bottom, 0.2)
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .sheet(isPresented: $showNutrientList, content: {
                        NutrientListSheetView(nutrients: recipeData.totalNutrients)
                            .presentationDetents([.medium, .large])
                    })
                    .sheet(isPresented: $showIngredientList, content: {
                        IngredientListSheetView(ingredients: recipeData.ingredients)
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
        RecipeDetailsView(recipeID: "d086f51bd7ca046eac74bda9198ece46", userID: "")
            .environmentObject(AuthViewModel())
    }
}
