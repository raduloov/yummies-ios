//
//  Constants.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

import Foundation

struct K {
    static let BASE_URL = "https://api.edamam.com/api/recipes/v2"
    static let API_KEY = "4ff1f43b02fdbe737da004ee39fd1367"
    
    struct URLs {
        static func recipesByName(_ name: String) -> URL {
            return URL(string: "\(K.BASE_URL)?type=public&beta=false&q=\(name)&app_id=9775e9bb&app_key=\(K.API_KEY)")!
        }
        
        static func recipeById(_ id: String) -> URL {
            return URL(string: "https://recipesapi.herokuapp.com/api/v2/recipes/\(id)")!
        }
        
    }
}
