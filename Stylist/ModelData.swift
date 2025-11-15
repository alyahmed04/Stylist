//
//  ModelData.swift
//  Stylist
//
// This observable class was implemented to have a singular instance of the list to modify its values or add values throughout any of the files.
//
//  Created by Aly Ahmed on 11/15/25.
//

import Foundation

//Observable class learned from 'Handling user input' that was assigned in the 'Introducing SwiftUI' apple tutorial path

@Observable class ModelData {
    var clothingItems: [ClothingItem] = [ClothingItem(id: UUID(), name: "Uniqlo White Shirt", category: .top, color: .white, fit: .oversized, notes: "This shirt is an XL size", isFavorite: true), ClothingItem(id: UUID(), name: "Uniqlo jacket", category: .outerwear, color: .black, fit: .oversized, notes: "This a black coat", isFavorite: true), ClothingItem(id: UUID(), name: "Abercrombie baggy jeans", category: .bottom, color: .blue, fit: .oversized, notes: nil, isFavorite: false), ClothingItem(id: UUID(), name: "Yankees baseball hat", category: .accessory, color: .black, fit: .regular, notes: nil, isFavorite: true), ClothingItem(id: UUID(), name: "Nike AirMax", category: .footwear, color: .brown, fit: .regular, notes: "This is a brown shoe with a cream sole", isFavorite: true)]
    
}






