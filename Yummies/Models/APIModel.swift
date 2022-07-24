//
//  APIModels.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

struct Recipes: Codable {
    let hits: [Results]
}

struct Results: Identifiable, Codable {
    var id: String { recipe.url }
    let recipe: Recipe
}

struct Recipe: Codable {
    let label: String
    let source: String
    let image: String
    let url: String
    let dietLabels: [String]
    let healthLabels: [String]
    let ingredientLines: [String]
    let calories: Double
    let totalTime: Double
    let cuisineType: [String]
    let mealType: [String]
    let dishType: [String]
    let totalNutrients: TotalNutrients
}

struct TotalNutrients: Codable {
    let kcals: Nutrients
    let fat: Nutrients
    let satFat: Nutrients
    let carbs: Nutrients
    let fiber: Nutrients
    let sugars: Nutrients
    let protein: Nutrients
    
    enum CodingKeys: String, CodingKey {
        case kcals = "ENERC_KCAL"
        case fat = "FAT"
        case satFat = "FASAT"
        case carbs = "CHOCDF"
        case fiber = "FIBTG"
        case sugars = "SUGAR"
        case protein = "PROCNT"
    }
}

struct Nutrients: Codable {
    let label: String
    let quantity: Double
    let unit: String
}
