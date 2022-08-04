//
//  CategoriesSheetView.swift
//  Yummies
//
//  Created by Yavor Radulov on 25.07.22.
//

import SwiftUI

struct CategoriesSheetView: View {
    
    var userID: String
    
    @Binding var categoryData: Category
    @Binding var currentCategory: CategoryType
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("").padding(.top, 30)) {
                    FormRowView(
                        categoryData: $categoryData,
                        currentCategory: $currentCategory,
                        emoji: "⭐️",
                        title: "Featured",
                        query: ""
                    )
                    FormRowView(
                        categoryData: $categoryData,
                        currentCategory: $currentCategory,
                        emoji: "📌",
                        title: "Pinned",
                        query: "",
                        userID: userID
                    )
                }
                
                Section(header: Text("Featured").font(.system(.title2))) {
                    ForEach(0 ..< featuredCategories.count, id: \.self) { index in
                        FormRowView(
                            categoryData: $categoryData,
                            currentCategory: $currentCategory,
                            emoji: featuredCategories[index].emoji,
                            title: featuredCategories[index].title,
                            query: featuredCategories[index].query!
                        )
                    }
                }
                
                Section(header: Text("Other Categories").font(.system(.title2))) {
                    ForEach(0 ..< categories.count, id: \.self) { index in
                        FormRowView(
                            categoryData: $categoryData,
                            currentCategory: $currentCategory,
                            emoji: categories[index].emoji,
                            title: categories[index].title,
                            query: categories[index].query!
                        )
                    }
                }
            }
        }
    }
}

struct FormRowView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var homeVM: HomeViewModel
    @StateObject private var hapticFeedback = HapticFeedback()
    @Binding var categoryData: Category
    @Binding var currentCategory: CategoryType
    
    var emoji: String
    var title: String
    var query: String
    var userID: String?
    
    var body: some View {
        Button(action: {
            if title == "Featured" {
                didSelectHome()
            } else if title == "Pinned" {
                didSelectPinned()
            } else {
                didSelectCategory(category: Category(emoji: emoji, title: title, query: query))
            }
            
            hapticFeedback.trigger(intensity: .medium)
        }) {
            HStack {
                Text(emoji)
                Spacer()
                Text(title)
            }
            .foregroundColor(Color.black)
            .font(.system(.title3, design: .rounded))
        }
    }
    
    func didSelectCategory(category: Category) {
        dismiss()
        categoryData = category
        currentCategory = .specific
    }
    
    func didSelectHome() {
        dismiss()
        categoryData = Category(emoji: "⭐️", title: "Featured")
        currentCategory = .featured
    }
    
    func didSelectPinned() {
        dismiss()
        categoryData = Category(emoji: "📌", title: "Pinned")
        currentCategory = .pinned
        homeVM.getPinnedRecipeIDs(userID: userID!)
    }
}

struct CategoriesSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSheetView(
            userID: "",
            categoryData: .constant(Category(emoji: "✨", title: "Featured")),
            currentCategory: .constant(.featured)
        )
    }
}
