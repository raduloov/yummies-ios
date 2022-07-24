//
//  Categories.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

struct Category {
    let title: String
    let url: String
}

let categories: [Category] = [
    Category(title: "🚀 Trending", url: "\(K.BASE_URL)?type=public&beta=false&q=salad&app_id=9775e9bb&app_key=\(K.API_KEY)"),
    Category(title: "🥗 Salad", url: "\(K.BASE_URL)?type=public&beta=false&q=salad&app_id=9775e9bb&app_key=\(K.API_KEY)"),
    Category(title: "🍔 Burgers", url: "\(K.BASE_URL)?type=public&beta=false&q=burgers&app_id=9775e9bb&app_key=\(K.API_KEY)"),
    Category(title: "🍕 Pizza", url: "\(K.BASE_URL)?type=public&beta=false&q=pizza&app_id=9775e9bb&app_key=\(K.API_KEY)"),
    Category(title: "🍣 Sushi", url: "\(K.BASE_URL)?type=public&beta=false&q=sushi&app_id=9775e9bb&app_key=\(K.API_KEY)")
]
