//
//  MealCardVM.swift
//  Yummies
//
//  Created by Yavor Radulov on 1.09.22.
//

import SwiftUI

class MealCardViewModel: ObservableObject {
    
    func getRecipeID(from uri: String) -> String {
        // Extract recipe ID from URI
        return String(uri.suffix(32))
    }
}
