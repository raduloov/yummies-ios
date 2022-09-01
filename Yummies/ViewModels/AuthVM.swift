//
//  LoginVM.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Combine

class AuthViewModel: ObservableObject {
    
    var didChange = PassthroughSubject<AuthViewModel, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    
    @Published var session: User? { didSet { self.didChange.send(self) }}
    @Published var error: String = ""
    
    func listen () {
        // Monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user, user.displayName != nil {
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email,
                    photoURL: user.photoURL
                )
            } else {
                self.session = nil
            }
        }
    }
    
    func signUpWithEmail(email: String, password: String, fullName: String) {
        error = ""
        
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            guard let user = result?.user, err == nil else {
                self.error = err!.localizedDescription
                return
            }
            
            Database.shared.createUserCollection(userID: user.uid)
            
            // Set user's display name
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = fullName
            changeRequest?.commitChanges { error in
                if let err = error {
                    self.error = err.localizedDescription
                }
            }
        }
    }
    
    func signInWithEmail(email: String, password: String) {
        error = ""
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            
            guard result != nil, err == nil else {
                self.error = err!.localizedDescription
                return
            }
            
            Database.shared.createUserCollection(userID: result!.user.uid)
        }
    }
    
    func signInWithGoogle() {
        error = ""
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ApplicationUtility.rootViewController) { user, err in
            if let error = err {
                self.error = error.localizedDescription
                return
            }
            
            guard
                let authentication = user?.authentication, let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { result, err in
                if let error = err {
                    self.error = error.localizedDescription
                    return
                }
                
                guard let user = result?.user else { return }
                
                Database.shared.createUserCollection(userID: user.uid)
            }
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Signed out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

class User {
    var uid: String
    var email: String?
    var displayName: String?
    var photoURL: URL?
    
    init(uid: String, displayName: String?, email: String?, photoURL: URL?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.photoURL = photoURL
    }
}

