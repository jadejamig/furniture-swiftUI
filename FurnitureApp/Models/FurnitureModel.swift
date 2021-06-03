//
//  FurnitureModel.swift
//  FurnitureApp
//
//  Created by Anselm Jade Jamig on 6/2/21.
//

import SwiftUI

struct Furniture: Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var price: Float
    var stars: Int
    var seller: String
    var colors: [Color]
}

let furnitures = [
    Furniture(image: "popular1", name: "Modern Style Sofa", price: 298.00, stars: 4, seller: "IKEA", colors: [.black, Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), .purple]),
    Furniture(image: "popular2", name: "Lounge Chair", price: 29.99, stars: 5, seller: "Timber Industries", colors: [.black, .blue, .purple]),
    Furniture(image: "popular3", name: "Elowen Chair", price: 60.00, stars: 5, seller: "Lacquer Craft", colors: [.black, .yellow, .red])
]
