//
//  APIModels.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

struct Recipes: Codable {
    let hits: [Result]
}

struct Result: Identifiable, Codable {
    var id: String { recipe.url }
    let recipe: Recipe
}

struct Recipe: Codable {
    let uri: String
    let label: String
    let source: String
    let image: String
    let url: String
    let dietLabels: [String]
    let healthLabels: [String]
    let ingredientLines: [String]
    let calories: Double
    let totalTime: Double
    let totalWeight: Double
    let cuisineType: [String]
    let mealType: [String]
    let dishType: [String]
    let totalNutrients: TotalDaily
}

struct TotalDaily: Codable {
    let kcals: Nutrients
    let fat: Nutrients
    let satFat: Nutrients
    let transFat: Nutrients
    let monoFat: Nutrients
    let polyunFat: Nutrients
    let carbs: Nutrients
    let fiber: Nutrients
    let sugars: Nutrients
    let protein: Nutrients
    let cholesterol: Nutrients
    let NA: Nutrients
    let CA: Nutrients
    let MG: Nutrients
    let K: Nutrients
    let FE: Nutrients
    let ZN: Nutrients
    let P: Nutrients
    let vitaminA: Nutrients
    let vitaminC: Nutrients
    let thiamin: Nutrients
    let riboflavin: Nutrients
    let niacin: Nutrients
    let vitaminB6: Nutrients
    let vitaminB12: Nutrients
    let vitaminD: Nutrients
    let vitaminE: Nutrients
    let vitaminK: Nutrients
    
    enum CodingKeys: String, CodingKey {
        case kcals = "ENERC_KCAL"
        case fat = "FAT"
        case satFat = "FASAT"
        case transFat = "FATRN"
        case monoFat = "FAMS"
        case polyunFat = "FAPU"
        case carbs = "CHOCDF"
        case fiber = "FIBTG"
        case sugars = "SUGAR"
        case protein = "PROCNT"
        case cholesterol = "CHOLE"
        case vitaminA = "VITA_RAE"
        case vitaminC = "VITC"
        case thiamin = "THIA"
        case riboflavin = "RIBF"
        case niacin = "NIA"
        case vitaminB6 = "VITB6A"
        case vitaminB12 = "VITB12"
        case vitaminD = "VITD"
        case vitaminE = "TOCPHA"
        case vitaminK = "VITK1"
        case NA, CA, MG
        case K, FE, ZN
        case P
    }
}

struct Nutrients: Codable {
    let label: String
    let quantity: Double
    let unit: String
}
