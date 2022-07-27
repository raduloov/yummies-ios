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
    @Published var selectedCategoryRecipes: [Result] = []
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
    
    func populateSelectedCategory(query: String) async {
        
        DispatchQueue.main.async {
            self.recipesLoaded = false
            self.fetchingError = false
        }
        
        do {
            let recipesResponse = try await RecipeService().get(url: K.URLs.recipesByName(query)) { data in
                return try? JSONDecoder().decode(Recipes.self, from: data)
            }

            DispatchQueue.main.async {
                self.selectedCategoryRecipes = recipesResponse.hits
                self.recipesLoaded = true
            }
        } catch {
            DispatchQueue.main.async {
                self.fetchingError = true
            }
            print(error)
        }
    }
    
    func refreshRecipes(currentCategoryData: Category) async {
        if let query = currentCategoryData.query {
            await populateSelectedCategory(query: query)
        } else {
            await populateFeaturedCategories()
        }
    }
}



