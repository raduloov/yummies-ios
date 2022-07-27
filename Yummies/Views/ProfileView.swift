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
    
    var body: some View {
        ZStack {
            Color("bgGradient1")
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
                
                Spacer()
                
                Button(action: {
                    authVM.singOut()
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
    }
        
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
