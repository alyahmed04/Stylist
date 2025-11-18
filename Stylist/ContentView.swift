//
//  ContentView.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authVM = AuthViewModel()
    var body: some View {
        Group {
            if authVM.isAuthenticated {
                MainTabView()
            }
            
            else {
                LoginView()
            }
        }
        .environmentObject(authVM)
        .environment(modelData)
    }
}

#Preview {
    ContentView().environment(ModelData())
}
