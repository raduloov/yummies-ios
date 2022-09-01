//
//  ProfileVM.swift
//  Yummies
//
//  Created by Yavor Radulov on 1.09.22.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var dateJoined: String = ""
    @Published var pinnedRecipesCount: Int = 0
    
    func setDateJoined(userID: String) {
        Database.shared.getDateJoined(userID: userID) { date in
            self.dateJoined = date
        }
    }
    
    func setPinnedRecipesCount(userID: String) {
        Database.shared.getPinnedRecipes(userID: userID) { recipes in
            self.pinnedRecipesCount = recipes.count
        }
    }
}
