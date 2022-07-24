//
//  HomeScreenVM.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var recipes: [[Results]] = []
    
    func populateCategories() async {
        
        for category in categories {
            do {
                let recipesResponse = try await FetchData().get(url: K.URLs.recipesByName(category.query)) { data in
                    return try? JSONDecoder().decode(Recipes.self, from: data)
                }

                DispatchQueue.main.async {
                    self.recipes.append(recipesResponse.hits)
                }
            } catch {
                print(error)
            }
        }
    }
}



