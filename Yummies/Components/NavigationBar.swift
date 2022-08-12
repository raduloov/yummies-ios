//
//  NavigationBar.swift
//  Yummies
//
//  Created by Yavor Radulov on 27.07.22.
//

import SwiftUI

struct NavigationBar: View {
    
    var dismiss: DismissAction
    var title: String?
    var pinButton: Bool = false
    var userID: String?
    var recipeID: String?
    
    @StateObject private var hapticFeedback = HapticFeedback()
    @State private var isPinned: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertText: String = "Recipe pinned! 📌"
    
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.black)
            }
            
            Spacer()
            
            if title != nil {
                Text(title!)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color.black)
                    .frame(alignment: .center)
            }
            
            Spacer()
            
            if pinButton {
                Button(action: {
                    guard let uid = userID else { return }
                    
                    if !isPinned {
                        Database().pinRecipe(userID: uid, recipeID: recipeID!)
                        alertText = "Recipe pinned! 📌"
                        hapticFeedback.trigger(intensity: .rigid)
                    } else {
                        Database().unpinRecipe(userID: uid, recipeID: recipeID!)
                        alertText = "Recipe unpinned! 💔"
                        hapticFeedback.trigger(intensity: .medium)
                    }
                    
                    isPinned.toggle()
                    showAlert = true
                }) {
                    Image(systemName: isPinned ? "pin.fill" : "pin")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.red)
                }
            } else {
                // Empty element to help with alignment
                Button(action: {
                    
                }) {
                }
                .opacity(0)
            }
        }
        .frame(height: 25)
        .padding()
        .onAppear {
            if let userID = userID, let recipeID = recipeID {
                Database().checkIsPinned(userID: userID, recipeID: recipeID) { recipeIsPinned in
                    isPinned = recipeIsPinned
                }
            }
        }
        .alert(alertText, isPresented: $showAlert) {
            Button("Great!", role: .cancel) { }
        }
    }
}

//struct NavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationBar()
//    }
//}
