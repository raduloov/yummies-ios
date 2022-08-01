//
//  Categories.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

enum CategoryType {
    case featured
    case specific
    case search
}

struct Featured {
    let title: String
    let query: String
}

struct Category {
    let emoji: String
    let title: String
    var query: String?
}

let featured: [Featured] = [
    Featured(title: "🚀 Popular", query: "popular"),
    Featured(title: "🥗 Salad", query: "salad"),
    Featured(title: "🍔 Burgers", query: "burger"),
    Featured(title: "🍕 Pizza", query: "pizza"),
    Featured(title: "🍣 Sushi", query: "sushi"),
    Featured(title: "🐉 Chinese", query: "chinese"),
    Featured(title: "🍰 Dessert", query: "dessert")
]

let categories: [Category] = [
    Category(emoji: "☕️", title: "Breakfast", query: "breakfast"),
    Category(emoji: "🍝", title: "Pasta", query: "pasta"),
    Category(emoji: "🐠", title: "Fish", query: "fish"),
    Category(emoji: "🦐", title: "Seafood", query: "seafood"),
    Category(emoji: "🍜", title: "Soup", query: "soup"),
    Category(emoji: "🍚", title: "Rice", query: "rice"),
    Category(emoji: "🌮", title: "Wraps", query: "wrap"),
    Category(emoji: "🇮🇳", title: "Indian", query: "indian"),
    Category(emoji: "🇮🇹", title: "Italian", query: "italian"),
    Category(emoji: "🇲🇽", title: "Mexican", query: "mexican"),
    Category(emoji: "🇹🇭", title: "Thai", query: "thai")
]

let featuredCategories: [Category] = [
    Category(emoji: "🚀", title: "Popular", query: "popular"),
    Category(emoji: "🥗", title: "Salad", query: "salad"),
    Category(emoji: "🍔", title: "Burgers", query: "burgers"),
    Category(emoji: "🍕", title: "Pizza", query: "pizza"),
    Category(emoji: "🍣", title: "Sushi", query: "sushi"),
    Category(emoji: "🐉", title: "Chinese", query: "chinese"),
    Category(emoji: "🍰", title: "Dessert", query: "dessert"),
]
