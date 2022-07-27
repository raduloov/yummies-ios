//
//  NutrientStickers.swift
//  Yummies
//
//  Created by Yavor Radulov on 25.07.22.
//

import SwiftUI

struct NutrientStickers: View {
    
    var nutrients: [Nutrient]
    
    var body: some View {
        HStack {
//            Spacer()
            
            ForEach(0 ..< nutrients.count, id: \.self) { index in
                NutrientSticker(
                    color: nutrients[index].color,
                    label: nutrients[index].label,
                    quantity: nutrients[index].quantity,
                    units: nutrients[index].units
                )

//                Spacer()
            }
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

struct Nutrient {
    let color: String
    let label: String
    let quantity: String
    let units: String
}

//struct NutrientStickers_Previews: PreviewProvider {
//    static var previews: some View {
//        NutrientStickers(kcal: "100", protein: "100", sugars: "100")
//    }
//}
