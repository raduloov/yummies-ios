//
//  Categories.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

struct Category {
    let title: String
    let query: String
}

let categories: [Category] = [
    Category(title: "🚀 Trending", query: "trending"),
    Category(title: "🥗 Salad", query: "salad"),
    Category(title: "🍔 Burgers", query: "burger"),
    Category(title: "🍕 Pizza", query: "pizza"),
    Category(title: "🍣 Sushi", query: "sushi"),
    Category(title: "🍰 Dessert", query: "dessert")
]
