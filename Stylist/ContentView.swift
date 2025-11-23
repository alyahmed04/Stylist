//
//  ContentView.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        Group {
            if authVM.isAuthenticated {
                // User is logged in - show home screen
                HomeView()
                    .transition(.move(edge: .trailing))
            } else {
                // User is not logged in - show login screen
                LoginView()
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: authVM.isAuthenticated)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}

