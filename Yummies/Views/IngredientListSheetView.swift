//
//  IngredientListSheetView.swift
//  Yummies
//
//  Created by Yavor Radulov on 27.07.22.
//

import SwiftUI

struct IngredientListSheetView: View {
    
    let ingredients: [IngredientDTO]
    
    var body: some View {
            List {
                ForEach(0 ..< ingredients.count, id: \.self) { index in
                    HStack {
                        Text(ingredients[index].food)
                        
                        Spacer()
                        
                        if let quantity = ingredients[index].quantity,
                           let measure = ingredients[index].measure {
                            Text("\(String(format: "%.1f", quantity)) \(measure != "<unit>" ? measure : "")")
                        }
                    }
                }
            }
    }
}

//struct IngredientListSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientListSheetView(ingre)
//    }
//}
