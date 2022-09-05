//
//  RecipeDetailsVM.swift
//  Yummies
//
//  Created by Yavor Radulov on 27.07.22.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    
    @Published var recipeData: ResultDTO?
    @Published var recipeLoaded: Bool = false
    @Published var fetchingError: Bool = false
    
    func populateRecipeData(recipeID: String) async {
        
        DispatchQueue.main.async {
            self.recipeLoaded = false
            self.fetchingError = false
        }
        
        do {
            let recipeResponse = try await RecipeService().get(url: Constants.URLs.recipeById(recipeID)) { data in
                return try? JSONDecoder().decode(ResultDTO.self, from: data)
            }

            DispatchQueue.main.async {
                self.recipeData = recipeResponse
                self.recipeLoaded = true
            }
        } catch {
            DispatchQueue.main.async {
                self.fetchingError = true
            }
            print(error)
        }
    }
}
