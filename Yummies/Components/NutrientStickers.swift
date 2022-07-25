//
//  NutrientStickers.swift
//  Yummies
//
//  Created by Yavor Radulov on 25.07.22.
//

import SwiftUI

struct NutrientStickers: View {
    
    var kcal: String
    var protein: String
    var sugars: String
    
    var body: some View {
        HStack {
            NutrientSticker(color: "kcalSticker", label: "KCal", quantity: kcal, units: "kcal")
            
            Spacer()
            
            NutrientSticker(color: "proteinSticker", label: "Protein", quantity: protein, units: "g")
            
            Spacer()
            
            NutrientSticker(color: "sugarSticker", label: "Sugar", quantity: sugars, units: "g")
        }
        .padding(.horizontal)
    }
}

struct NutrientSticker: View {
    
    var color: String
    var label: String
    var quantity: String
    var units: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(color))
                .overlay(
                    Circle()
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 3, dash: [2]))
                )
            VStack {
                Text("\(label)\n\(quantity)\(units == "g" ? "g" : "")")
                    .foregroundColor(Color.black)
                    .font(.system(.footnote, design: .rounded))
            }
        }
        .frame(width: 55, height: 55)
    }
}

struct NutrientStickers_Previews: PreviewProvider {
    static var previews: some View {
        NutrientStickers(kcal: "100", protein: "100", sugars: "100")
    }
}
