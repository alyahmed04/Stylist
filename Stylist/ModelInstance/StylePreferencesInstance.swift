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


//Code learned and gotten from:
//https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
extension StylePreferences{
    static var stylePreferences: [StylePreferences] = [StylePreferences(id: UUID(), user: User.sampleUser[0], style: "Casual", fit: "Relaxed", color: "Neutrals", shoppingFreq: "Weekly"), StylePreferences(id: UUID(), user: User.sampleUser[1], style: "Professional", fit: "Tailored", color: "Dark Tones", shoppingFreq: "Monthly"), StylePreferences(id: UUID(), user: User.sampleUser[2], style: "Streetwear", fit: "Oversized", color: "Bright Colors", shoppingFreq: "Weekly"), StylePreferences(id: UUID(), user: User.sampleUser[3], style: "Active", fit: "Tight", color: "Neutrals", shoppingFreq: "Rarely"), ]
}
