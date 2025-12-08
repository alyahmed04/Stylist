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
let cost = [" < $50", "$50-100", "$100-$500","$500+"]


//Code learned and gotten from:
//https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
extension StylePreferences{
    static var stylePreferences: [StylePreferences] = [
        StylePreferences(id: UUID(), user: User.sampleUser[0], style: "Casual", fit: "Relaxed", color: "Neutrals", shoppingFreq: "Weekly", cost: " < $50"),
        StylePreferences(id: UUID(), user: User.sampleUser[1], style: "Professional", fit: "Tailored", color: "Dark Tones", shoppingFreq: "Monthly", cost: "$50-$100"),
        StylePreferences(id: UUID(), user: User.sampleUser[2], style: "Active", fit: "Tight", color: "Neutrals", shoppingFreq: "Rarely", cost: "$100-$500"),
        StylePreferences(id: UUID(), user: User.sampleUser[3], style: "Casual", fit: "Tight", color: "Neutrals", shoppingFreq: "Rarely", cost: "$100-$500"),
        StylePreferences(id : UUID(), user : User.sampleUser[4], style: "Streetwear", fit: "Relaxed", color: "Dark Tones", shoppingFreq: "Weekly", cost: " < $50"),
        StylePreferences(id : UUID(), user : User.sampleUser[5], style: "Streetwear", fit: "Tight", color: "Dark Tones", shoppingFreq: "Rarely",
            cost: "$100-$500"),
        StylePreferences(id : UUID(), user : User.sampleUser[6], style: "Casual", fit: "Relaxed", color: "Bright Colors", shoppingFreq: "Monthly", cost: " < $50"),
        StylePreferences(id : UUID(), user : User.sampleUser[7], style: "Casual", fit: "Tailored", color: "Neutrals", shoppingFreq: "Monthly", cost: "$500+")
    ]
}
