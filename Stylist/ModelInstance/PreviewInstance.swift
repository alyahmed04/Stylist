//
//  PreviewInstance.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/23/25.
//

import Foundation
import SwiftData


struct Preview{
    
    //Gotten and learned from
    //https://www.hackingwithswift.com/quick-start/swiftdata/how-to-add-multiple-configurations-to-a-modelcontainer
    var container: ModelContainer
    init() {
        do {
            let config1 = ModelConfiguration(for: User.self, isStoredInMemoryOnly: true)
            let config2 = ModelConfiguration(for: ClothingItem.self, isStoredInMemoryOnly: true)

            container = try ModelContainer(for: User.self, ClothingItem.self, configurations: config1, config2)
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
    }
    
    //Code learned and gotten from:
    //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
    func addUsers(_ examples: [User]){
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
    
    //Code learned and gotten from:
    //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
    func addClothingItems(_ examples: [ClothingItem]){
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
    
    
}

