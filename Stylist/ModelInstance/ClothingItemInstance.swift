//
//  ClothingItemInstance.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/23/25.
//

import Foundation

//Code learned and gotten from:
//https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
extension ClothingItem{
    static var clothingItems: [ClothingItem] = [ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Uniqlo White Shirt", category: .top, mainColor: .white, accentColor: .none, fit: .oversized, notes: "This shirt is an XL size", brand: "Uniqlo", isFavorite: true)]
}
