//
//  HomeScreenVM.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    let config = Config()
    
    @Published var featuredRecipes: [[ResultDTO]] = []
    @Published var fetchedRecipes: [ResultDTO] = []
    @Published var pinnedRecipes: [ResultDTO] = []
    @Published var pinnedRecipeIDs: [String] = []
    @Published var recipesLoaded: Bool = false
    @Published var fetchingError: Bool = false
    
    func populateFeaturedCategories() async {
        
        DispatchQueue.main.async {
            self.fetchingError = false
        }
        
        for category in config.featured {
            do {
                let recipesResponse = try await RecipeService().get(url: Constants.URLs.recipesByName(category.query)) { data in
                    return try? JSONDecoder().decode(RecipesDTO.self, from: data)
                }

                DispatchQueue.main.async {
                    self.featuredRecipes.append(recipesResponse.hits)
                }
            } catch {
                DispatchQueue.main.async {
                    self.fetchingError = true
                }
                print(error)
            }
        }
    }
    
    func populateByQuery(query: String) async {
        
        DispatchQueue.main.async {
            self.recipesLoaded = false
            self.fetchingError = false
        }
        
        do {
            let recipesResponse = try await RecipeService().get(url: Constants.URLs.recipesByName(query)) { data in
                return try? JSONDecoder().decode(RecipesDTO.self, from: data)
            }

            DispatchQueue.main.async {
                self.fetchedRecipes = recipesResponse.hits
                self.recipesLoaded = true
            }
        } catch {
            DispatchQueue.main.async {
                self.fetchingError = true
            }
            print(error)
        }
    }
    
    func getPinnedRecipeIDs(userID: String) {
        Database.shared.getPinnedRecipes(userID: userID) { recipes in
            self.pinnedRecipeIDs = recipes
        }
    }
    
    func populatePinnedRecipes(_ recipes: [String]) async {
        DispatchQueue.main.async {
            self.fetchingError = false
            self.pinnedRecipes = []
        }
        
        for recipeID in recipes {
            do {
                let recipeResponse = try await RecipeService().get(url: Constants.URLs.recipeById(recipeID)) { data in
                    return try? JSONDecoder().decode(ResultDTO.self, from: data)
                }

                DispatchQueue.main.async {
                    self.pinnedRecipes.append(recipeResponse)
                }
            } catch {
                DispatchQueue.main.async {
                    self.fetchingError = true
                }
                print(error)
            }
        }
    }
    
    func refreshRecipes(currentCategoryData: Category) async {
        if let query = currentCategoryData.query {
            await populateByQuery(query: query)
        } else {
            await populateFeaturedCategories()
        }
    }
    
    // Conditional rendering
    func recipesDidLoad(category: CategoryType) -> Bool {
        
        switch category {
        case .specific:
            return recipesLoaded
        case .search:
            return recipesLoaded
        case .featured:
            return featuredRecipes.count >= config.featured.count
        case .pinned:
            return pinnedRecipes.count >= pinnedRecipeIDs.count
        }
    }
    
    
}



