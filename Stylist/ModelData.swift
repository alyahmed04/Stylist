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
    var clothingItems: [ClothingItem] = [ClothingItem(id: UUID(), name: "Uniqlo White Shirt", category: .top, mainColor: .white, fit: .oversized, notes: "This shirt is an XL size", brand: "Uniqlo", isFavorite: true), ClothingItem(id: UUID(), name: "Uniqlo jacket", category: .outerwear, mainColor: .black, fit: .oversized, notes: "This a black coat", brand: "Uniqlo", isFavorite: true), ClothingItem(id: UUID(), name: "Abercrombie baggy jeans", category: .bottom, mainColor: .blue, fit: .oversized, notes: nil, brand: "Abercrombie", isFavorite: false), ClothingItem(id: UUID(), name: "Yankees baseball hat", category: .accessory, mainColor: .black, fit: .regular, notes: nil, brand: "abercrombie", isFavorite: true), ClothingItem(id: UUID(), name: "Nike AirMax", category: .footwear, mainColor: .brown, fit: .regular, notes: "This is a brown shoe with a cream sole", brand: "Nike", isFavorite: true)]
    
}






