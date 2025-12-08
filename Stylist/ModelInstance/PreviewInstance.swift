//
//  PreviewInstance.swift
//  Stylist
//
// This file sets
//
//  Created by Aly Ahmed on 11/23/25.
//

import Foundation
import SwiftData
import SwiftUI


struct Preview{
    
    //Gotten and learned from
    //https://www.hackingwithswift.com/quick-start/swiftdata/how-to-add-multiple-configurations-to-a-modelcontainer
    var container: ModelContainer
    init() {
        do {
            //The config used to be two lines and was changed to 1 to fix the crashing issue
            //Solution was gotten from claude
            //Original Code:
            //  let config1 = ModelConfiguration(for: User.self, isStoredInMemoryOnly: true)
//            let config2 = ModelConfiguration(for: ClothingItem.self, isStoredInMemoryOnly: true)
//
//            container = try ModelContainer(for: User.self, ClothingItem.self, configurations: config1, config2)
            //Conversation:
            
            let config = ModelConfiguration(for: User.self, ClothingItem.self, StylePreferences.self, isStoredInMemoryOnly: true)

            container = try ModelContainer(for: User.self, ClothingItem.self, StylePreferences.self, configurations: config)
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
    }
    
    //The functions were changed to not use async to fix preview issue
    //Solution was gotten from claude
    //Original Code:
    //Code learned and gotten from:
//        //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
//        func addUsers(_ examples: [User]){
//            Task { @MainActor in
//                examples.forEach { example in
//                    container.mainContext.insert(example)
//                }
//            }
//        }
//        
//        //Code learned and gotten from:
//        //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
//        func addClothingItems(_ examples: [ClothingItem]){
//            Task { @MainActor in
//                examples.forEach { example in
//                    container.mainContext.insert(example)
//                }
//            }
//        }
    //Conversation:
    
    //Code learned and gotten from:
    //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
    func addUsers(_ examples: [User]){
                examples.forEach { example in
                    container.mainContext.insert(example)
                }
            }
        
        
        //Code learned and gotten from:
        //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
        func addClothingItems(_ examples: [ClothingItem]){
                examples.forEach { example in
                    container.mainContext.insert(example)
                }
            }
    
    func addStylePreferences(_ examples: [StylePreferences]){
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    
        
    
    
}
