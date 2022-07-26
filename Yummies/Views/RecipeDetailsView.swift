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
    @State private var showWebView: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                NavigationBar(dismiss: dismiss, pinButton: !recipeDetailsVM.fetchingError ? true : false, userID: userID, recipeID: recipeID)
                
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
                    .frame(width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT / 2)
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
                                NutrientStickersRowLarge(nutrients: [
                                    Nutrient(color: Color("kcalSticker"), label: "KCal", quantity: Int(recipeData.totalNutrients.kcals.quantity), units: "kcal"),
                                    Nutrient(color: Color("proteinSticker"), label: "Protein", quantity: Int(recipeData.totalNutrients.protein.quantity), units: "g")
                                ])
                                NutrientStickersRowLarge(nutrients: [
                                    Nutrient(color: Color("carbsSticker"), label: "Carbs", quantity: Int(recipeData.totalNutrients.carbs.quantity), units: "g"),
                                    Nutrient(color: Color("sugarSticker"), label: "Sugars", quantity: Int(recipeData.totalNutrients.sugars.quantity), units: "g")
                                ])
                                NutrientStickersRowLarge(nutrients: [
                                    Nutrient(color: Color("satFatSticker"), label: "Sat. Fat", quantity: Int(recipeData.totalNutrients.satFat.quantity), units: "g"),
                                    Nutrient(color: Color("fiberSticker"), label: "Fiber", quantity: Int(recipeData.totalNutrients.fiber.quantity), units: "g")
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
                        
                        VStack {
                            HStack {
                                Text("More info")
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.medium)
                                
                                 Spacer()
                            }
                            .padding(.vertical, 10)
                            
                            HStack {
                                Button(action: {
                                    showWebView.toggle()
                                    hapticFeedback.trigger(intensity: .rigid)
                                }) {
                                    HStack {
                                        Image(systemName: "info.circle")
                                            .font(.system(.body, design: .rounded))
                                            .foregroundColor(Color.black)
                                        Text("Go to webpage")
                                            .font(.system(.title2, design: .rounded))
                                            .foregroundColor(Color.black)
                                    }
                                }
                                .buttonStyle(.bordered)
                                
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
                    .sheet(isPresented: $showWebView) {
                        VStack {
                            VStack {
                                Capsule()
                                    .foregroundColor(Color.gray)
                                    .frame(width: 100, height: 5)
                                    .padding(.top, 10)
                                
                                HStack {
                                    Button(action: {
                                        showWebView.toggle()
                                        hapticFeedback.trigger(intensity: .soft)
                                    }) {
                                        Image(systemName: "xmark.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(Color.black)
                                    }
                                    
                                    Spacer()
                                }
                                .frame(height: 25)
                                .padding(.horizontal, 10)
                            }
                            WebView(url: URL(string: recipeData.url)!)
                        }
                    }
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
