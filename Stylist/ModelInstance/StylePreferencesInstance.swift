//
//  StylePreferencesInstance.swift
//  Stylist
//
//  Created by Aly Ahmed on 12/7/25.
//

import Foundation



//Code learned and gotten from:
//https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
extension StylePreferences{
    static var stylePreferences: [StylePreferences] = [StylePreferences(id: UUID(), user: User.sampleUser[0], style: "Casual", fit: "Relaxed", color: "Neutrals", shoppingFreq: "Weekly")]
}
