//
//  AllNutrientsSheetView.swift
//  Yummies
//
//  Created by Yavor Radulov on 27.07.22.
//

import SwiftUI

struct NutrientListSheetView: View {
    
    let nutrients: TotalNutrients
    
    var body: some View {
        List {
            Group {
                HStack {
                    Text(nutrients.kcals.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.kcals.quantity)))
                    Text(nutrients.kcals.unit)
                }
                HStack {
                    Text(nutrients.fat.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.fat.quantity)))
                    Text(nutrients.fat.unit)
                }
                HStack {
                    Text(nutrients.satFat.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.satFat.quantity)))
                    Text(nutrients.satFat.unit)
                }
                HStack {
                    Text(nutrients.transFat.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.transFat.quantity)))
                    Text(nutrients.transFat.unit)
                }
                HStack {
                    Text(nutrients.monoFat.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.monoFat.quantity)))
                    Text(nutrients.monoFat.unit)
                }
                HStack {
                    Text(nutrients.polyunFat.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.polyunFat.quantity)))
                    Text(nutrients.polyunFat.unit)
                }
                HStack {
                    Text(nutrients.carbs.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.carbs.quantity)))
                    Text(nutrients.carbs.unit)
                }
                HStack {
                    Text(nutrients.fiber.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.fiber.quantity)))
                    Text(nutrients.fiber.unit)
                }
                HStack {
                    Text(nutrients.sugars.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.sugars.quantity)))
                    Text(nutrients.sugars.unit)
                }
                HStack {
                    Text(nutrients.protein.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.protein.quantity)))
                    Text(nutrients.protein.unit)
                }
            }
            Group {
                HStack {
                    Text(nutrients.protein.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.protein.quantity)))
                    Text(nutrients.protein.unit)
                }
                HStack {
                    Text(nutrients.NA.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.NA.quantity)))
                    Text(nutrients.NA.unit)
                }
                HStack {
                    Text(nutrients.CA.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.CA.quantity)))
                    Text(nutrients.CA.unit)
                }
                HStack {
                    Text(nutrients.MG.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.MG.quantity)))
                    Text(nutrients.MG.unit)
                }
                HStack {
                    Text(nutrients.K.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.K.quantity)))
                    Text(nutrients.K.unit)
                }
                HStack {
                    Text(nutrients.FE.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.FE.quantity)))
                    Text(nutrients.FE.unit)
                }
                HStack {
                    Text(nutrients.ZN.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.ZN.quantity)))
                    Text(nutrients.ZN.unit)
                }
                HStack {
                    Text(nutrients.P.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.P.quantity)))
                    Text(nutrients.P.unit)
                }
                HStack {
                    Text(nutrients.vitaminA.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.vitaminA.quantity)))
                    Text(nutrients.vitaminA.unit)
                }
                HStack {
                    Text(nutrients.vitaminC.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.vitaminC.quantity)))
                    Text(nutrients.vitaminC.unit)
                }
            }
            Group {
                HStack {
                    Text(nutrients.thiamin.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.thiamin.quantity)))
                    Text(nutrients.thiamin.unit)
                }
                HStack {
                    Text(nutrients.riboflavin.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.riboflavin.quantity)))
                    Text(nutrients.riboflavin.unit)
                }
                HStack {
                    Text(nutrients.niacin.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.niacin.quantity)))
                    Text(nutrients.niacin.unit)
                }
                HStack {
                    Text(nutrients.vitaminB6.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.vitaminB6.quantity)))
                    Text(nutrients.vitaminB6.unit)
                }
                HStack {
                    Text(nutrients.vitaminB12.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.vitaminB12.quantity)))
                    Text(nutrients.vitaminB12.unit)
                }
                HStack {
                    Text(nutrients.vitaminD.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.vitaminD.quantity)))
                    Text(nutrients.vitaminD.unit)
                }
                HStack {
                    Text(nutrients.vitaminE.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.vitaminE.quantity)))
                    Text(nutrients.vitaminE.unit)
                }
                HStack {
                    Text(nutrients.vitaminK.label)
                    
                    Spacer()
                    
                    Text(String(Int(nutrients.vitaminK.quantity)))
                    Text(nutrients.vitaminK.unit)
                }
            }
        }
    }
}

//struct AllNutrientsSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllNutrientsSheetView()
//    }
//}
