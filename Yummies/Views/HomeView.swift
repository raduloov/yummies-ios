//
//  HomeScreenView.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import FirebaseAuth

struct HomeScreenView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var homeVM = HomeViewModel()
    @State var showCategories: Bool = false
    @State var currentCategoryType: CategoryType = CategoryType.featured
    @State var currentCategoryData: Category = Category(emoji: "✨", title: "Featured")
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("bgGradient1"), Color("bgGradient2")], startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HomeHeader(showCategoriesSheet: $showCategories)
                
                ScrollView {
                    Text("\(currentCategoryData.emoji) \(currentCategoryData.title)")
                        .font(.system(size: 35, weight: .heavy, design: .rounded))
                        .padding(.bottom, 20)
                    
                    if currentCategoryType == CategoryType.featured {
                        if homeVM.featuredRecipes.count != featured.count {
                            VStack {
                                LoadingIndicator(text: "Getting recipes...", size: 2)
                            }
                            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2)
                        } else {
                            VStack {
                                ForEach(0 ..< featured.count, id: \.self) { index in
                                    Group {
                                        HStack {
                                            Text(featured[index].title)
                                                .font(.system(.title, design: .rounded))
                                                .fontWeight(.heavy)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(alignment: .top) {
                                                ForEach(homeVM.featuredRecipes[index]) { recipe in
                                                    MealCard(
                                                        uri: recipe.recipe.uri,
                                                        imageUrl: recipe.recipe.image,
                                                        label: recipe.recipe.label,
                                                        nutrients: recipe.recipe.totalNutrients
                                                    )
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Text("@2022 Yavor Radulov")
                                .font(.system(.caption, design: .rounded))
                        }
                    }
                    
                    if currentCategoryType == CategoryType.specific {
                        ScrollView {
                            if !homeVM.recipesLoaded {
                                VStack {
                                    LoadingIndicator(text: "Getting recipes...", size: 2)
                                }
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2)
                            } else {
                                VStack {
                                    ForEach(homeVM.selectedCategoryRecipes) { recipe in
                                        MealCard(
                                            uri: recipe.recipe.uri,
                                            imageUrl: recipe.recipe.image,
                                            label: recipe.recipe.label,
                                            nutrients: recipe.recipe.totalNutrients
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
        .sheet(isPresented: $showCategories) {
            if #available(iOS 16.0, *) {
                CategoriesSheetView(
                    categoryData: $currentCategoryData,
                    currentCategory: $currentCategoryType
                )
                .presentationDetents([.medium, .large])
            } else {
                // Fallback on earlier versions
                CategoriesSheetView(
                    categoryData: $currentCategoryData,
                    currentCategory: $currentCategoryType
                )
                .navigationTitle("Categories")
            }
        }
        .task {
            if currentCategoryType == CategoryType.featured && homeVM.featuredRecipes.count < categories.count {
                await homeVM.populateFeaturedCategories()
            } else if currentCategoryType == CategoryType.specific && !homeVM.recipesLoaded {
                await homeVM.populateSelectedCategory(query: currentCategoryData.query!)
            }
        }
        .onChange(of: currentCategoryData.title) { _ in
            Task { await homeVM.populateSelectedCategory(query: currentCategoryData.query!) }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthViewModel())
    }
}
