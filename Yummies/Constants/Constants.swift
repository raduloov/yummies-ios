//
//  Constants.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

import UIKit
import SwiftUI

struct Constants {
    static let BASE_URL = "https://api.edamam.com/api/recipes/v2"
    static let API_KEY = "4ff1f43b02fdbe737da004ee39fd1367"
    static let APP_ID = "9775e9bb"
    
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    
    struct URLs {
        static func recipesByName(_ name: String) -> URL {
            return URL(string: "\(Constants.BASE_URL)?type=public&beta=false&q=\(name)&app_id=\(Constants.APP_ID)&app_key=\(Constants.API_KEY)")!
        }
        
        static func recipeById(_ id: String) -> URL {
            return URL(string: "\(Constants.BASE_URL)/\(id)?type=public&app_id=\(Constants.APP_ID)&app_key=\(Constants.API_KEY)")!
        }
        
    }
}

extension Color {
    static var background: Color {
        Color("background")
    }
}
