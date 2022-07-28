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
        
        docRef.getDocument { document, error in
            if !document!.exists {
                db.collection(userID).document("favorites").setData([:])
                
                if let error = error {
                    fatalError("Unable to create favorites document: \(error.localizedDescription)")
                }
            }
        }
    }
}
