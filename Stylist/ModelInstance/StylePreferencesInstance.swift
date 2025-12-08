//
//  StylePreferencesInstance.swift
//  Stylist
//
//  Created by Aly Ahmed on 12/7/25.
//

import Foundation



let styleOptions = ["Casual", "Streetwear", "Professional", "Active"]
let fitOptions = ["Tight", "Tailored", "Relaxed", "Oversized"]
let colorChoices = ["Neutrals", "Dark tones", "Bright colors"]
let shoppingOptions = ["Weekly", "Monthly", "Rarely"]
let cost = ["Less than $50", "$50-$100", "More than $100"]


//Code learned and gotten from:
//https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
extension StylePreferences{
    static var stylePreferences: [StylePreferences] = [
        StylePreferences(id: UUID(), user: User.sampleUser[0], style: "Casual", fit: "Relaxed", color: "Neutrals", shoppingFreq: "Weekly", cost: "Less than $50"),
        StylePreferences(id: UUID(), user: User.sampleUser[1], style: "Professional", fit: "Tailored", color: "Dark Tones", shoppingFreq: "Monthly", cost: "$50-$100"), StylePreferences(id: UUID(), user: User.sampleUser[2], style: "Streetwear", fit: "Oversized", color: "Bright Colors", shoppingFreq: "Weekly", cost: "Less than $50"),
        StylePreferences(id: UUID(), user: User.sampleUser[3], style: "Active", fit: "Tight", color: "Neutrals", shoppingFreq: "Rarely", cost: "More than $100"),
        StylePreferences(id: UUID(), user: User.sampleUser[3], style: "Old Money", fit: "Tight", color: "Neutrals", shoppingFreq: "Rarely", cost: "More than $100"),
        StylePreferences(id : UUID(), user : User.sampleUser[4], style: "Streetwear", fit: "Relaxed", color: "Dark Tones", shoppingFreq: "Weekly", cost: "Less than $100"),
        StylePreferences(id : UUID(), user : User.sampleUser[5], style: "Rock", fit: "Tight", color: "Dark Tones", shoppingFreq: "Rarely",
            cost: "More than $100"),
        StylePreferences(id : UUID(), user : User.sampleUser[6], style: "Beach", fit: "Relaxed", color: "Bright Colors", shoppingFreq: "Monthly", cost: "Less than $50"),
        StylePreferences(id : UUID(), user : User.sampleUser[7], style: "Corporate", fit: "Tailored", color: "Neutrals", shoppingFreq: "Monthly", cost: "More than $100")
    ]
}
