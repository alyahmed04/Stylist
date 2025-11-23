import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        Group {
            if (authVM.isAuthenticated) {
                if (!authVM.completedStyleQuiz) {
                    NavigationStack {
                        StyleQuizView()
                            .environmentObject(authVM)
                    }
                }
                else {
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
                                Label("Outfits", systemImage: "shirt.fill")
                            }
                    }
                }
            }
            else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}

#Preview {
    MainTabView()
        .environment(ModelData())
        .environmentObject(AuthViewModel())
}
