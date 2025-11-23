//
//  StylistApp.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI
import SwiftData

@main
struct StylistApp: App {
    
    //Code gotten and learned from:
    //https://www.hackingwithswift.com/quick-start/swiftdata/how-to-add-multiple-configurations-to-a-modelcontainer
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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(container)
    }
}
