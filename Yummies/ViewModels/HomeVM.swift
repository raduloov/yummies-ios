//
//  HomeScreenVM.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var featuredRecipes: [[Result]] = []
    @Published var fetchedRecipes: [Result] = []
    @Published var pinnedRecipes: [Result] = []
    @Published var pinnedRecipeIDs: [String] = []
    @Published var recipesLoaded: Bool = false
    @Published var fetchingError: Bool = false
    
    func populateFeaturedCategories() async {
        
        DispatchQueue.main.async {
            self.fetchingError = false
        }
        
        for category in featured {
            do {
                let recipesResponse = try await RecipeService().get(url: K.URLs.recipesByName(category.query)) { data in
                    return try? JSONDecoder().decode(Recipes.self, from: data)
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
            let recipesResponse = try await RecipeService().get(url: K.URLs.recipesByName(query)) { data in
                return try? JSONDecoder().decode(Recipes.self, from: data)
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
        Database().getPinnedRecipes(userID: userID) { recipes in
            self.pinnedRecipeIDs = recipes
            print(self.pinnedRecipeIDs)
        }
    }
    
    func populatePinnedRecipes(recipes: [String]) async {
        DispatchQueue.main.async {
            self.fetchingError = false
            self.pinnedRecipes = []
        }
        
        for recipeID in recipes {
            do {
                let recipeResponse = try await RecipeService().get(url: K.URLs.recipeById(recipeID)) { data in
                    return try? JSONDecoder().decode(Result.self, from: data)
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
}



