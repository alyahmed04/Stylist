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
        
        //casual (user 1)
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Uniqlo White Shirt", category: .top, mainColor: .white, accentColor: .none, fit: .relaxed, notes: "This shirt is an XL size", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Uniqlo jacket", category: .outerwear, mainColor: .black, accentColor: .none, fit: .oversized, notes: "This a black coat made of a polyester material", brand: ""),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Abercrombie Jeans", category: .bottom, mainColor: .black, accentColor: .none, fit: .oversized, notes: "These jeans stack well on lower to the ground shoes", brand: "Abercrombie and Fitch"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Adidas Sambas", category: .footwear, mainColor: .white, accentColor: .black, fit: .regular, notes: "This is a low to the ground shoe", brand: "Adidas"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Baseball Cap", category: .accessory, mainColor: .black, accentColor: .white, fit: .regular, notes: "The cap has a yankees logo on it", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Nike Sweatpants", category: .bottom, mainColor: .gray, accentColor: .none, fit: .relaxed, notes: "This a black coat", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[0], name: "Long Coat", category: .outerwear, mainColor: .black, accentColor: .none, fit: .relaxed, notes: "This a black coat", brand: "COS"),
        
        //professional (user 2)
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Black Dress Shoes", category: .bottom, mainColor: .black, accentColor: .none, fit: .relaxed, notes: "These shoes are made from a luxery italian leather", brand: "Prada"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "White Sneaker Shoes", category: .bottom, mainColor: .black, accentColor: .none, fit: .relaxed, notes: "These shoes are an elevated casual shoe", brand: "Banana Republic"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Suit pants", category: .bottom, mainColor: .black, accentColor: .none, fit: .regular, notes: "", brand: "Ralph Lauren"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Suit pants", category: .bottom, mainColor: .brown, accentColor: .none, fit: .regular, notes: "The pants have a lighter cream like color shade of brown", brand: "Ralph Lauren"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Suit Jacket", category: .outerwear, mainColor: .blue, accentColor: .none, fit: .regular, notes: "This is a navy suit jacket", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "white shirt", category: .top, mainColor: .white, accentColor: .none, fit: .regular, notes: "", brand: "Uniqlo"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "Black Button up shirt", category: .top, mainColor: .black, accentColor: .none, fit: .regular, notes: "", brand: "Calvin Klein"),
        ClothingItem(id: UUID(), user: User.sampleUser[1], name: "White Button up shirt", category: .top, mainColor: .white, accentColor: .none, fit: .oversized, notes: "", brand: "Calvin Klein"),
        
        
        
        //athletic closet (user 3)
        ClothingItem(id: UUID(), user: User.sampleUser[2], name: "Red Hoodie", category: .outerwear, mainColor: .red, accentColor: .none, fit: .relaxed, notes: "Red hoodie with Adidas logo", brand: "Adidas"),
        ClothingItem(id: UUID(), user: User.sampleUser[2], name: "Running Shorts", category: .bottom, mainColor: .black, accentColor: .none, fit: .regular, notes: "Lightweight running shorts", brand: "Nike"),
        ClothingItem(id: UUID(), user: User.sampleUser[2], name: "Gym Tank Top", category: .top, mainColor: .gray, accentColor: .none, fit: .slim, notes: "Tank top for workouts", brand: "Under Armour"),
        ClothingItem(id: UUID(), user: User.sampleUser[2], name: "Running Shoes", category: .footwear, mainColor: .red, accentColor: .black, fit: .regular, notes: "Running shoes with cushioning", brand: "Nike"),
        ClothingItem(id: UUID(), user: User.sampleUser[2], name: "Jogger Pants", category: .bottom, mainColor: .gray, accentColor: .none, fit: .relaxed, notes: "Comfortable jogger pants for relaxing", brand: "Adidas"),
        ClothingItem(id: UUID(), user: User.sampleUser[2], name: "White T-Shirt", category: .top, mainColor: .white, accentColor: .none, fit: .regular, notes: "Basic white cotton t-shirt", brand: "Hanes"),
        
        //old money (user 4)
        ClothingItem(id: UUID(), user: User.sampleUser[3], name: "Beige Linen Shirt", category: .top, mainColor: .brown, accentColor: .none, fit: .regular, notes: "Lightweight linen shirt", brand: "ASOS"),
        ClothingItem(id: UUID(), user: User.sampleUser[3], name: "Light Gray Sweater", category: .top, mainColor: .gray, accentColor: .none, fit: .regular, notes: "Crew neck sweater", brand: "H&M"),
        ClothingItem(id: UUID(), user: User.sampleUser[3], name: "Trousers", category: .bottom, mainColor: .white, accentColor: .none, fit: .regular, notes: "Tailored light trousers", brand: "ASOS"),
        ClothingItem(id: UUID(), user: User.sampleUser[3], name: "Black Coat", category: .outerwear, mainColor: .black, accentColor: .none, fit: .regular, notes: "Simple black wool coat", brand: "Banana Republic"),
        ClothingItem(id: UUID(), user: User.sampleUser[3], name: "White Leather Sneakers", category: .footwear, mainColor: .white, accentColor: .none, fit: .regular, notes: "White tight fitting leather shoes", brand: "Banana Republic"),
        ClothingItem(id: UUID(), user: User.sampleUser[3], name: "Gray Wool Pants", category: .bottom, mainColor: .gray, accentColor: .none, fit: .regular, notes: "Comfortable gray pants with wool lining", brand: "Prada"),
        ClothingItem(id: UUID(), user: User.sampleUser[3], name: "Scarf", category: .accessory, mainColor: .gray, accentColor: .white, fit: .regular, notes: "Lightweight wool blend scarf", brand: "Banana Republic"),
        
        
        //streetwear (user 5)
        ClothingItem(id: UUID(), user: User.sampleUser[4], name: "Oversized Graphic Hoodie", category: .outerwear, mainColor: .black, accentColor: .white, fit: .oversized, notes: "Oversized graphic hoodie with picture of rose on chest", brand: "Gucci"),
        ClothingItem(id: UUID(), user: User.sampleUser[4], name: "Cargo Pants", category: .bottom, mainColor: .gray, accentColor: .black, fit: .relaxed, notes: "Relaxed cargo pants with utility pockets", brand: "H&M"),
        ClothingItem(id: UUID(), user: User.sampleUser[4], name: "High Top Sneakers", category: .footwear, mainColor: .black, accentColor: .red, fit: .regular, notes: "High top dark sneakers", brand: "Jordan"),
        ClothingItem(id: UUID(), user: User.sampleUser[4], name: "Oversized Jacket", category: .outerwear, mainColor: .brown, accentColor: .none, fit: .oversized, notes: "Oversized brown jacket", brand: "Zara"),
        ClothingItem(id: UUID(), user: User.sampleUser[4], name: "Baggy Jeans", category: .bottom, mainColor: .blue, accentColor: .none, fit: .oversized, notes: "Baggy blue jeans that are straight fit", brand: "H&M"),
        ClothingItem(id: UUID(), user: User.sampleUser[4], name: "Chain Necklace", category: .accessory, mainColor: .gray, accentColor: .none, fit: .regular, notes: "Silver chunky chain necklace", brand: "Boohooman"),
        
        //rock (user 6)
        ClothingItem(id: UUID(), user: User.sampleUser[5], name: "Black Rock T-Shirt", category: .top, mainColor: .black, accentColor: .white, fit: .slim, notes: "Vintage band tee", brand: "Disturbia"),
        ClothingItem(id: UUID(), user: User.sampleUser[5], name: "Ripped Black Jeans", category: .bottom, mainColor: .black, accentColor: .none, fit: .slim, notes: "Black jeans with strategic rips", brand: "Disturbia"),
        ClothingItem(id: UUID(), user: User.sampleUser[5], name: "Black Leather Jacket", category: .outerwear, mainColor: .black, accentColor: .none, fit: .slim, notes: "Black leather jacket silver sleeves", brand: "Disturbia"),
        ClothingItem(id: UUID(), user: User.sampleUser[5], name: "Metal Choker", category: .accessory, mainColor: .gray, accentColor: .black, fit: .regular, notes: "Metal choker necklace", brand: "Disturbia"),
        ClothingItem(id: UUID(), user: User.sampleUser[5], name: "Fishnet Top", category: .top, mainColor: .black, accentColor: .none, fit: .slim, notes: "Black fishnet long sleeve top", brand: "Disturbia"),
 
        
        //beach (user 7)
        ClothingItem(id: UUID(), user: User.sampleUser[6], name: "Striped Rashguard", category: .top, mainColor: .blue, accentColor: .white, fit: .slim, notes: "Blue and white striped rashguard", brand: "Salty Crew"),
        ClothingItem(id: UUID(), user: User.sampleUser[6], name: "Board Shorts", category: .bottom, mainColor: .orange, accentColor: .none, fit: .relaxed, notes: "Bright orange board shorts", brand: "Salty Crew"),
        ClothingItem(id: UUID(), user: User.sampleUser[6], name: "Flip Flops", category: .footwear, mainColor: .brown, accentColor: .none, fit: .regular, notes: "Comfortable brown flip flops", brand: "Salty Crew"),
        ClothingItem(id: UUID(), user: User.sampleUser[6], name: "Surfer Tee", category: .top, mainColor: .white, accentColor: .none, fit: .oversized, notes: "Faded white vintage surfer tee", brand: "Salty Crew"),
        ClothingItem(id: UUID(), user: User.sampleUser[6], name: "Lightweight Jacket", category: .outerwear, mainColor: .yellow, accentColor: .none, fit: .relaxed, notes: "Bright yellow windbreaker ", brand: "Salty Crew"),
        
        
        
        //corporate (user 8)
        ClothingItem(id: UUID(), user: User.sampleUser[7], name: "Blue Dress Shirt", category: .top, mainColor: .blue, accentColor: .white, fit: .regular, notes: "Blue oxford button down shirt with light accent", brand: "ASOS"),
        ClothingItem(id: UUID(), user: User.sampleUser[7], name: "Gray Chino Pants", category: .bottom, mainColor: .gray, accentColor: .none, fit: .regular, notes: "Tailored gray chino pants for office", brand: "ASOS"),
        ClothingItem(id: UUID(), user: User.sampleUser[7], name: "Loafers", category: .footwear, mainColor: .brown, accentColor: .none, fit: .regular, notes: "Brown leather loafers", brand: "Ralph Lauren"),
        ClothingItem(id: UUID(), user: User.sampleUser[7], name: "Cardigan Sweater", category: .outerwear, mainColor: .gray, accentColor: .none, fit: .regular, notes: "Gray cardigan for layering", brand: "Banana Republic"),
        ClothingItem(id: UUID(), user: User.sampleUser[7], name: "Watch", category: .accessory, mainColor: .gray, accentColor: .none, fit: .regular, notes: "Silver fancy watch", brand: "The Citizen")
        
    
    ]
}
