//
//  ContentView.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel
    let preview = Preview()
    var body: some View {
       
        
        Group {
            if authVM.isAuthenticated {
                // User is logged in - show home screen
                MainTabView()
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
    let preview = Preview()
    ContentView()
        .modelContainer(preview.container).environmentObject({
            let vm = AuthViewModel()
            vm.currentUser = nil
            vm.isAuthenticated = false
            return vm
        }())
}

