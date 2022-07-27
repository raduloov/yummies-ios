//
//  HomeHeader.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI

struct HomeHeader: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    @Binding var showCategoriesSheet: Bool
    @State private var text: String = ""
    
    var body: some View {
        HStack {
            TextField("Search for a recipe", text: $text)
                .textFieldStyle(GradientTextFieldBackground())
            
            Button(action: {
                showCategoriesSheet.toggle()
            }) {
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    .resizable()
                    .foregroundColor(Color.black.opacity(0.75))
                    .frame(width: 35, height: 35)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
            
            NavigationLink(destination: ProfileView()
                .toolbar(.hidden)
                .environmentObject(authVM)
                .navigationTitle("Profile"), label: {
                    AsyncImage(url: authVM.session?.photoURL) { image in
                        image
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    } placeholder: {
                        Image(systemName: "person")
                            .resizable()
                            .foregroundColor(Color.black.opacity(0.75))
                            .frame(width: 35, height: 35)
                    }
                    .frame(width: 35, height: 35)
                })
        }
        .frame(width: K.SCREEN_WIDTH - 30, height: 40)
        .padding(.vertical)
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
        HomeHeader(showCategoriesSheet: .constant(false))
            .environmentObject(AuthViewModel())
    }
}
