//
//  NutrientStickers.swift
//  Yummies
//
//  Created by Yavor Radulov on 25.07.22.
//

import SwiftUI

struct NutrientStickers: View {
    
    let nutrients: [Nutrient]
    
    var body: some View {
            HStack {
                ForEach(0 ..< nutrients.count, id: \.self) { index in
                    NutrientSticker(
                        color: nutrients[index].color,
                        label: nutrients[index].label,
                        quantity: nutrients[index].quantity,
                        units: nutrients[index].units
                    )
                }
            }
            .padding(.horizontal)
        }
}

struct NutrientStickersRowLarge: View {
    
    let nutrients: [Nutrient]
    
    var body: some View {
        HStack {
            ForEach(0 ..< nutrients.count, id: \.self) { index in
                NutrientStickerLarge(
                    color: nutrients[index].color,
                    label: nutrients[index].label,
                    quantity: nutrients[index].quantity,
                    units: nutrients[index].units
                )
            }
        }
    }
}


struct NutrientSticker: View {
    
    let color: Color
    let label: String
    let quantity: Int
    let units: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .overlay(
                    Circle()
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 3, dash: [2]))
                )
                Text("\(label)\n\(String(quantity))\(units == "g" ? "g" : "")")
                    .foregroundColor(Color.black)
                    .font(.system(.footnote, design: .rounded))
        }
        .frame(width: 55, height: 55)
    }
}

struct NutrientStickerLarge: View {
    
    let color: Color
    let label: String
    let quantity: Int
    let units: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(color.gradient)
                .frame(height: 70)
                .overlay {
                    RoundedRectangle(cornerRadius: 35)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 3, dash: [2]))
                    HStack {
                        Circle()
                            .fill(Color.white.opacity(0.7))
                            .padding(7)
                            .overlay {
                                Text(String(quantity))
                                    .fontWeight(.medium)
                            }
                        VStack(alignment: .leading) {
                            Text(label)
                                .font(.system(size: 20, weight: .medium))
                            Text(units == "g" ? "Grams" : "KCal")
                                .foregroundColor(Color.black.opacity(0.6))
                                .fontWeight(.medium)
                        }
                        
                        Spacer()
                    }
                }
        }
    }
}

struct Nutrient {
    let color: Color
    let label: String
    let quantity: Int
    let units: String
}

//struct NutrientStickers_Previews: PreviewProvider {
//    static var previews: some View {
//        NutrientStickers(kcal: "100", protein: "100", sugars: "100")
//    }
//}
