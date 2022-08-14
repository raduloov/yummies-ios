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
        let userRef = db.collection("users").document(userID)
        
        // If there is no collection with the current user ID, create one
        userRef.getDocument { document, error in
            if let error = error {
                fatalError("Unable to create pinned recipes document: \(error.localizedDescription)")
            }
            
            // Create empty pinned recipes array and date joined
            if !document!.exists {
                self.db.collection("users").document(userID).setData(["pinnedRecipes":[]])
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let dateJoined = dateFormatter.string(from: date)
                
                userRef.updateData([
                    "dateJoined": dateJoined
                ]) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        }
    }
    
    func pinRecipe(userID: String, recipeID: String) {
        
        let userRef = db.collection("users").document(userID)
        
        userRef.updateData([
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
        
        let userRef = db.collection("users").document(userID)
        
        userRef.updateData([
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
        
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let pinnedRecipes = document.data()!["pinnedRecipes"] as! [String]
                
                recipeIsPinned = pinnedRecipes.contains(where: { $0 == recipeID })
                
                completion(recipeIsPinned)
            }
        }
    }
    
    func getPinnedRecipes(userID: String, completion: @escaping (([String]) -> Void)) {
        
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let pinnedRecipes = document.data()!["pinnedRecipes"] as! [String]
                
                completion(pinnedRecipes)
            }
        }
    }
    
    func getDateJoined(userID: String, completion: @escaping ((String) -> Void)) {
        
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let dateJoined = document.data()!["dateJoined"] as! String

                completion(dateJoined)
            }
        }
    }
}
