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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
