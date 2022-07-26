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
    
    func populateFeaturedCategories() async {
        
        for category in featured {
            do {
                let recipesResponse = try await FetchData().get(url: K.URLs.recipesByName(category.query)) { data in
                    return try? JSONDecoder().decode(Recipes.self, from: data)
                }

                DispatchQueue.main.async {
                    self.featuredRecipes.append(recipesResponse.hits)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func populateSelectedCategory(query: String) async {
        
        self.recipesLoaded = false
        
        do {
            let recipesResponse = try await FetchData().get(url: K.URLs.recipesByName(query)) { data in
                return try? JSONDecoder().decode(Recipes.self, from: data)
            }

            DispatchQueue.main.async {
                self.selectedCategoryRecipes = recipesResponse.hits
                self.recipesLoaded = true
            }
        } catch {
            print(error)
        }
    }
}



