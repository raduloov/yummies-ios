//
//  MealCard.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

import SwiftUI

struct MealCard: View {
    
    var imageUrl: String
    var label: String
    
    var body: some View {
        Button(action: {
            print("recipe.recipe.totalNutrients.protein")
        }) {
            VStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                } placeholder: {
                    LoadingIndicator()
                }
                .frame(width: 200, height: 150)
                .cornerRadius(15)
                .shadow(radius: 5, x: 0, y: 5)
                
                Text(label)
                    .foregroundColor(Color.black)
                    .font(.system(.body, design: .rounded))
                    .frame(width: 200)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .padding()
    }
}

struct MealCard_Previews: PreviewProvider {
    static var previews: some View {
        MealCard(imageUrl: "", label: "Label")
    }
}
