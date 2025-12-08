//
//  StylePreferencesInstance.swift
//  Stylist
//
//  Created by Aly Ahmed on 12/7/25.
//

import Foundation




extension StylePreferences{
    static var stylePreferences: [StylePreferences] = [StylePreferences(id: UUID(), user: User.sampleUser[0], style: "Casual", fit: "Relaxed", color: "Neutrals", shoppingFreq: "Weekly")]
}
