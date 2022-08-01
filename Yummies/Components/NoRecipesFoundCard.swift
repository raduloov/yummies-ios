//
//  NoRecipesFoundCard.swift
//  Yummies
//
//  Created by Yavor Radulov on 1.08.22.
//

import SwiftUI

struct NoRecipesFoundCard: View {
    
    let searchTerm: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white.opacity(0.7))
            .overlay {
                VStack {
                    VStack {
                        Text("No recipes found for search term: \(searchTerm)")
                            .font(.system(.title2, design: .rounded))
                    }
                    .padding()
                }
            }
            .frame(width: 350, height: 150)
    }
}

struct NoRecipesFoundCard_Previews: PreviewProvider {
    static var previews: some View {
        NoRecipesFoundCard(searchTerm: "beeeeeef")
    }
}
