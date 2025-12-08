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
    static var clothingItems: [ClothingItem] = [
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Uniqlo White Shirt", category: .top, mainColor: .white, accentColor: .none, fit: .relaxed, notes: "This shirt is an XL size", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Uniqlo jacket", category: .outerwear, mainColor: .black, accentColor: .none, fit: .oversized, notes: "This a black coat made of a polyester material", brand: ""),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Abercrombie Jeans", category: .bottom, mainColor: .black, accentColor: .none, fit: .oversized, notes: "These jeans stack well on lower to the ground shoes", brand: "Abercrombie and Fitch"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Adidas Sambas", category: .footwear, mainColor: .white, accentColor: .black, fit: .regular, notes: "This is a low to the ground shoe", brand: "Adidas"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Baseball Cap", category: .accessory, mainColor: .black, accentColor: .white, fit: .regular, notes: "The cap has a yankees logo on it", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Nike Sweatpants", category: .bottom, mainColor: .gray, accentColor: .none, fit: .relaxed, notes: "This a black coat", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Long Coat", category: .outerwear, mainColor: .black, accentColor: .none, fit: .relaxed, notes: "This a black coat", brand: "COS"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Black Dress Shoes", category: .bottom, mainColor: .black, accentColor: .none, fit: .relaxed, notes: "These shoes are made from a luxery italian leather", brand: "Prada"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "White Sneaker Shoes", category: .bottom, mainColor: .black, accentColor: .none, fit: .relaxed, notes: "These shoes are an elevated casual shoe", brand: "Banana Republic"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Suit pants", category: .bottom, mainColor: .black, accentColor: .none, fit: .regular, notes: "", brand: "Ralph Lauren"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Suit pants", category: .bottom, mainColor: .brown, accentColor: .none, fit: .regular, notes: "The pants have a lighter cream like color shade of brown", brand: "Ralph Lauren"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Suit Jacket", category: .outerwear, mainColor: .blue, accentColor: .none, fit: .regular, notes: "This is a navy suit jacket", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "white shirt", category: .top, mainColor: .white, accentColor: .none, fit: .regular, notes: "", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Black Button up shirt", category: .top, mainColor: .black, accentColor: .none, fit: .regular, notes: "", brand: "Calvin Klein"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "White Button up shirt", category: .top, mainColor: .white, accentColor: .none, fit: .oversized, notes: "", brand: "Calvin Klein"),
        ClothingItem(id: UUID(), user: User.sampleUser[2], name: "Hoodie", category: .outerwear, mainColor: .red, accentColor: .white, fit: .relaxed, notes: "This is a red hoodie with the red cross logo in the middle. The hoodie is made out of a fuzzy material.", brand: "TheFirstStreet")]
}
