//
//  Firestore.swift
//  Yummies
//
//  Created by Yavor Radulov on 28.07.22.
//

import SwiftUI
import Firebase

class Database: ObservableObject {
    
    func createUserCollection(userID: String) {
        let db = Firestore.firestore()
        
        let docRef = db.collection(userID).document("favorites")
        
        // If there is no collection with the current user ID, create one
        docRef.getDocument { document, error in
            if !document!.exists {
                db.collection(userID).document("favorites").setData([:])
                
                if let error = error {
                    fatalError("Unable to create favorites document: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func addRecipeToFavorites(recipeID: String) {
        
    }
}
