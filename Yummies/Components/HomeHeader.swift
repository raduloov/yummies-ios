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
    @StateObject private var hapticFeedback = HapticFeedback()
    @Binding var showCategoriesSheet: Bool
    @Binding var searchTerm: String
    @Binding var categoryType: CategoryType
    @Binding var categoryData: Category
    @State private var text: String = ""
    
    var body: some View {
        HStack {
            TextField("Search for a recipe", text: $text)
                .textFieldStyle(GradientTextFieldBackground())
                .onSubmit {
                    guard $text.wrappedValue.count > 0 else { return }
                    
                    searchTerm = SearchUtil().formatSearchTerm(searchTerm: $text.wrappedValue)
                    categoryType = .search
                    categoryData = Category(emoji: "", title: "", query: searchTerm)
                }
            
            Button(action: {
                showCategoriesSheet.toggle()
                
                hapticFeedback.trigger(intensity: .medium)
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
                .navigationTitle("Profile")
                .onAppear {
                    hapticFeedback.trigger(intensity: .medium)
                }
                           , label: {
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
        .frame(width: Constants.SCREEN_WIDTH - 30, height: 40)
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
        HomeHeader(
            showCategoriesSheet: .constant(false),
            searchTerm: .constant(""),
            categoryType: .constant(.featured),
            categoryData: .constant(Category(emoji: "", title: ""))
        )
        .environmentObject(AuthViewModel())
    }
}
