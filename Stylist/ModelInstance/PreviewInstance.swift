//
//  PreviewInstance.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/23/25.
//

import Foundation
import SwiftData


struct Preview{
    
    var container: ModelContainer
    init() {
        do {
            let config1 = ModelConfiguration(for: User.self)
            let config2 = ModelConfiguration(for: ClothingItem.self)

            container = try ModelContainer(for: User.self, ClothingItem.self, configurations: config1, config2)
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
    }
    
}
