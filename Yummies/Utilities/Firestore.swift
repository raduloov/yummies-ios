//
//  Firestore.swift
//  Yummies
//
//  Created by Yavor Radulov on 28.07.22.
//

import SwiftUI
import Firebase

class Database: ObservableObject {
    
    let db = Firestore.firestore()
    
    func createUserCollection(userID: String) {
        let pinnedRecipesRef = db.collection("users").document(userID)
        
        // If there is no collection with the current user ID, create one
        pinnedRecipesRef.getDocument { document, error in
            if !document!.exists {
                self.db.collection("users").document(userID).setData(["pinnedRecipes":[]])
                
                if let error = error {
                    fatalError("Unable to create favorites document: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func pinRecipe(userID: String, recipeID: String) {
        
        let pinnedRecipesRef = db.collection("users").document(userID)
        
        pinnedRecipesRef.updateData([
            "pinnedRecipes": FieldValue.arrayUnion([recipeID])
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func unpinRecipe(userID: String, recipeID: String) {
        
        let pinnedRecipesRef = db.collection("users").document(userID)
        
        pinnedRecipesRef.updateData([
            "pinnedRecipes": FieldValue.arrayRemove([recipeID])
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func checkIsPinned(userID: String, recipeID: String, completion: @escaping ((Bool) -> Void)) {
        
        var recipeIsPinned: Bool = false
        
        let pinnedRecipesRef = db.collection("users").document(userID)
        
        pinnedRecipesRef.getDocument { document, error in
            if let document = document, document.exists {
                let pinnedRecipes = document.data()!["pinnedRecipes"] as! [Any]
                
                recipeIsPinned = pinnedRecipes.contains(where: { $0 as! String == recipeID })
                
                completion(recipeIsPinned)
            }
        }
    }
}
