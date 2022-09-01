//
//  ProfileView.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var profileVM = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationBar(dismiss: dismiss, title: "Profile")
                
                VStack {
                    AsyncImage(url: authVM.session?.photoURL) { image in
                        image
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(Color.black)
                            .padding()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    }
                    .frame(width: 150, height: 150)
                    .padding()
                    
                    Text(authVM.session?.displayName ?? "User")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.medium)
                }
                
                Form {
                    Section(header: Text("Profile info")) {
                        ProfileInfoRow(firstItem: "Full name:", secondItem: authVM.session?.displayName ?? "No Name")
                        ProfileInfoRow(firstItem: "Email:", secondItem: authVM.session?.email ?? "No Email")
                        ProfileInfoRow(firstItem: "Date joined:", secondItem: profileVM.dateJoined)
                        ProfileInfoRow(firstItem: "Recipes pinned:", secondItem: String(profileVM.pinnedRecipesCount))
                    }
                }
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                Button(action: {
                    authVM.signOut()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(Color.black)
                        Text("Sign out")
                            .font(.system(.title2, design: .rounded))
                            .foregroundColor(Color.black)
                    }
                }
                .buttonStyle(.bordered)
            }
        }
        .onAppear {
            profileVM.setDateJoined(userID: authVM.session!.uid)
            profileVM.setPinnedRecipesCount(userID: authVM.session!.uid)
        }
    }
}

struct ProfileInfoRow: View {
    
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        HStack {
            Text(firstItem)
            
            Spacer()
            
            Text(secondItem)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
