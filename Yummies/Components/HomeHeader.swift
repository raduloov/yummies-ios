//
//  HomeHeader.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI

struct HomeHeader: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State private var text: String = ""
    
    var body: some View {
        HStack {
            TextField("Search for a recipe", text: $text)
                .textFieldStyle(GradientTextFieldBackground())
            
            NavigationLink(destination: ProfileView()
                .environmentObject(authVM)
                .navigationTitle("Profile"), label: {
                    AsyncImage(url: authVM.session?.photoURL) { image in
                        image
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    } placeholder: {
                        Image(systemName: "person")
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 40, height: 40)
                })
        }
        .frame(height: 40)
        .padding()
    }
}

struct GradientTextFieldBackground: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(height: 40)
            
            HStack {
                Image(systemName: "magnifyingglass")
                
                // Reference the TextField here
                configuration
            }
            .padding(.leading)
            .foregroundColor(.gray)
        }
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader()
            .environmentObject(AuthViewModel())
    }
}
