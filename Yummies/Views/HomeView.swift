//
//  HomeScreenView.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import FirebaseAuth

struct HomeScreenView: View {
    
    let config = Config()
    
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var mealCardVM: MealCardViewModel
    @StateObject private var homeVM = HomeViewModel()
    @State var showCategories: Bool = false
    @State var currentCategoryType: CategoryType = CategoryType.featured
    @State var currentCategoryData: Category = Category(emoji: "⭐️", title: "Featured")
    @State var searchTerm: String = ""
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HomeHeader(
                    showCategoriesSheet: $showCategories,
                    searchTerm: $searchTerm,
                    categoryType: $currentCategoryType,
                    categoryData: $currentCategoryData
                )
                
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        Task {
                            await homeVM.refreshRecipes(currentCategoryData: currentCategoryData)
                        }
                    }
                    
                    if currentCategoryType != .search {
                        HStack {
                            Text("\(currentCategoryData.emoji) \(currentCategoryData.title)")
                                .font(.system(size: 35, weight: .heavy, design: .rounded))
                                .padding(.bottom, 20)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    if currentCategoryType == .pinned {
                        if homeVM.fetchingError {
                            ErrorCard {
                                Task {
                                    await homeVM.refreshRecipes(currentCategoryData: currentCategoryData)
                                }
                            }
                        } else if homeVM.recipesDidLoad(category: .pinned) {
                            VStack {
                                LoadingIndicator(text: "Getting recipes...", size: 2)
                            }
                            .frame(width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT / 2)
                        } else {
                            VStack {
                                ForEach(homeVM.pinnedRecipes) { recipe in
                                    VerticalMealCard(
                                        uri: recipe.recipe.uri,
                                        imageUrl: recipe.recipe.image,
                                        label: recipe.recipe.label,
                                        nutrients: recipe.recipe.totalNutrients,
                                        userID: authVM.session?.uid ?? ""
                                    )
                                }
                            }
                        }
                    }
                    
                    if currentCategoryType == .featured {
                        if !homeVM.recipesDidLoad(category: .featured) {
                            VStack {
                                LoadingIndicator(text: "Getting recipes...", size: 2)
                            }
                            .frame(width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT / 2)
                        } else {
                            VStack {
                                ForEach(0 ..< config.featured.count, id: \.self) { index in
                                    Group {
                                        HStack {
                                            Text(config.featured[index].title)
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
                                                        nutrients: recipe.recipe.totalNutrients,
                                                        userID: authVM.session?.uid ?? ""
                                                    )
                                                    .environmentObject(mealCardVM)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if currentCategoryType == .specific {
                        if homeVM.fetchingError {
                            ErrorCard {
                                Task {
                                    await homeVM.refreshRecipes(currentCategoryData: currentCategoryData)
                                }
                            }
                        } else if !homeVM.recipesDidLoad(category: .specific) {
                            VStack {
                                LoadingIndicator(text: "Getting recipes...", size: 2)
                            }
                            .frame(width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT / 2)
                        } else {
                            VStack {
                                ForEach(homeVM.fetchedRecipes) { recipe in
                                    VerticalMealCard(
                                        uri: recipe.recipe.uri,
                                        imageUrl: recipe.recipe.image,
                                        label: recipe.recipe.label,
                                        nutrients: recipe.recipe.totalNutrients,
                                        userID: authVM.session?.uid ?? ""
                                    )
                                }
                            }
                        }
                    }
                    
                    if currentCategoryType == .search {
                        if homeVM.fetchingError {
                            ErrorCard {
                                Task {
                                    await homeVM.refreshRecipes(currentCategoryData: currentCategoryData)
                                }
                            }
                        } else if !homeVM.recipesDidLoad(category: .search) {
                            VStack {
                                LoadingIndicator(text: "Getting recipes...", size: 2)
                            }
                            .frame(width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT / 2)
                        } else if homeVM.fetchedRecipes.count == 0 {
                            NoRecipesFoundCard(searchTerm: searchTerm)
                        } else {
                            VStack {
                                ForEach(homeVM.fetchedRecipes) { recipe in
                                    VerticalMealCard(
                                        uri: recipe.recipe.uri,
                                        imageUrl: recipe.recipe.image,
                                        label: recipe.recipe.label,
                                        nutrients: recipe.recipe.totalNutrients,
                                        userID: authVM.session?.uid ?? ""
                                    )
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
                userID: authVM.session!.uid,
                categoryData: $currentCategoryData,
                currentCategory: $currentCategoryType
            )
            .presentationDetents([.medium, .large])
            .environmentObject(homeVM)
        }
        .task {
            if currentCategoryType == .featured && homeVM.featuredRecipes.count < config.categories.count {
                await homeVM.populateFeaturedCategories()
            } else if currentCategoryType == .pinned {
                homeVM.getPinnedRecipeIDs(userID: authVM.session!.uid)
            } else if currentCategoryType == .specific && !homeVM.recipesLoaded {
                await homeVM.populateByQuery(query: currentCategoryData.query!)
            }
        }
        .onChange(of: homeVM.pinnedRecipeIDs) { _ in
            Task {
                await homeVM.populatePinnedRecipes(homeVM.pinnedRecipeIDs)
            }
        }
        .onChange(of: currentCategoryData.title) { _ in
            Task {
                if let query = currentCategoryData.query {
                    await homeVM.populateByQuery(query: query)
                } else {
                    await homeVM.populateFeaturedCategories()
                }
            }
        }
        .onChange(of: searchTerm) { _ in
            Task {
                await homeVM.populateByQuery(query: searchTerm)
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
