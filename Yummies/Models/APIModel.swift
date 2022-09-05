//
//  APIModels.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

struct RecipesDTO: Codable {
    let hits: [ResultDTO]
}

struct ResultDTO: Identifiable, Codable {
    var id: String { recipe.url }
    let recipe: RecipeDTO
}

struct RecipeDTO: Codable {
    let uri: String
    let label: String
    let source: String
    let image: String
    let url: String
    let dietLabels: [String]
    let healthLabels: [String]
    let ingredientLines: [String]
    let ingredients: [IngredientDTO]
    let calories: Double
    let totalTime: Double
    let totalWeight: Double
    let cuisineType: [String]
    let mealType: [String]
    let dishType: [String]
    let totalNutrients: TotalNutrientsDTO
}

struct TotalNutrientsDTO: Codable {
    let kcals: NutrientsDTO
    let fat: NutrientsDTO
    let satFat: NutrientsDTO
    let transFat: NutrientsDTO
    let monoFat: NutrientsDTO
    let polyunFat: NutrientsDTO
    let carbs: NutrientsDTO
    let fiber: NutrientsDTO
    let sugars: NutrientsDTO
    let protein: NutrientsDTO
    let cholesterol: NutrientsDTO
    let NA: NutrientsDTO
    let CA: NutrientsDTO
    let MG: NutrientsDTO
    let K: NutrientsDTO
    let FE: NutrientsDTO
    let ZN: NutrientsDTO
    let P: NutrientsDTO
    let vitaminA: NutrientsDTO
    let vitaminC: NutrientsDTO
    let thiamin: NutrientsDTO
    let riboflavin: NutrientsDTO
    let niacin: NutrientsDTO
    let vitaminB6: NutrientsDTO
    let vitaminB12: NutrientsDTO
    let vitaminD: NutrientsDTO
    let vitaminE: NutrientsDTO
    let vitaminK: NutrientsDTO
    
    enum CodingKeysDTO: String, CodingKey {
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

struct NutrientsDTO: Codable {
    let label: String
    let quantity: Double
    let unit: String
}

struct IngredientDTO: Codable {
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
}
