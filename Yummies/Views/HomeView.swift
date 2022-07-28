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
    @StateObject private var database = Database()
    @State var showCategories: Bool = false
    @State var currentCategoryType: CategoryType = CategoryType.featured
    @State var currentCategoryData: Category = Category(emoji: "⭐️", title: "Featured")
    
    var body: some View {
        ZStack {
            Color("bgGradient1")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HomeHeader(showCategoriesSheet: $showCategories)
                
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        Task {
                            await homeVM.refreshRecipes(currentCategoryData: currentCategoryData)
                        }
                    }
                    
                    Text("\(currentCategoryData.emoji) \(currentCategoryData.title)")
                        .font(.system(size: 35, weight: .heavy, design: .rounded))
                        .padding(.bottom, 20)
                    
                    if currentCategoryType == .featured {
                        if homeVM.fetchingError {
                            ErrorCard {
                                Task {
                                    await homeVM.refreshRecipes(currentCategoryData: currentCategoryData)
                                }
                            }
                        } else if homeVM.featuredRecipes.count < featured.count {
                            VStack {
                                LoadingIndicator(text: "Getting recipes...", size: 2)
                            }
                            .frame(width: K.SCREEN_WIDTH, height: K.SCREEN_HEIGHT / 2)
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
                                                    HorizontalMealCard(
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
                    
                    if currentCategoryType == .specific {
                        ScrollView {
                            if homeVM.fetchingError {
                                ErrorCard {
                                    Task {
                                        await homeVM.refreshRecipes(currentCategoryData: currentCategoryData)
                                    }
                                }
                            } else if !homeVM.recipesLoaded {
                                VStack {
                                    LoadingIndicator(text: "Getting recipes...", size: 2)
                                }
                                .frame(width: K.SCREEN_WIDTH, height: K.SCREEN_HEIGHT / 2)
                            } else {
                                VStack {
                                    ForEach(homeVM.selectedCategoryRecipes) { recipe in
                                        VerticalMealCard(
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
                .coordinateSpace(name: "pullToRefresh")
            }
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
        .sheet(isPresented: $showCategories) {
                CategoriesSheetView(
                    categoryData: $currentCategoryData,
                    currentCategory: $currentCategoryType
                )
                .presentationDetents([.medium, .large])
        }
        .task {
            if currentCategoryType == .featured && homeVM.featuredRecipes.count < categories.count {
                await homeVM.populateFeaturedCategories()
            } else if currentCategoryType == .specific && !homeVM.recipesLoaded {
                await homeVM.populateSelectedCategory(query: currentCategoryData.query!)
            }
        }
        .onChange(of: currentCategoryData.title) { _ in
            Task {
                if let query = currentCategoryData.query {
                    await homeVM.populateSelectedCategory(query: query)
                } else {
                    await homeVM.populateFeaturedCategories()
                }
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthViewModel())
    }
}
