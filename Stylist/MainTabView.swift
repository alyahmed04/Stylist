import SwiftUI
// Main file for tab view

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
    MainTabView()
        .environment(ModelData())
        .environmentObject(AuthViewModel())
}
