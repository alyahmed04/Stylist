//
//  MainTabView.swift
//  Stylist
//
//
//
//  Created by  on 11/15/25.
//


import SwiftUI
import SwiftData


struct MainTabView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            Closet()
                .tabItem {
                    Label("Closet", systemImage: "hanger")
                }

            OutfitRecommendation()
                .tabItem {
                    Label("Outfits", systemImage: "tshirt.fill")
                }
        }
    }
}

#Preview {
    let preview = Preview()
    preview.addUsers(User.sampleUser)
    preview.addClothingItems(ClothingItem.clothingItems)
    preview.addStylePreferences(StylePreferences.stylePreferences)
    
    
    return MainTabView().modelContainer(preview.container).environmentObject({
        let vm = AuthViewModel()
        vm.currentUser = User.sampleUser[0]
        vm.isAuthenticated = true
        return vm
    }())
}
