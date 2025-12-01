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
    @State private var modelData = ModelData()
    @StateObject private var authVM = AuthViewModel()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)          // shared closet and currentUser
                .environmentObject(authVM)       // shared auth session
        }
        .modelContainer(for: User.self)
    }
}
