import SwiftUI
import SwiftData

struct HomeView: View {
    // Shared closet data
   // @Environment(ModelData.self) var modelData
    
    // Our existing auth view model
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Greeting
                    headerSection
                    
                    // Closet summary
                    closetCard
                    
                    // Recommendation card
                    recommendationCard
                    
                    // Style Quiz card
                    quizCard
                    
                    // Tip of the Day
                    tipCard
                }
                .padding()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hello, \(usernameText) 👋")
                .font(.largeTitle.bold())
            
            Text("Let’s build your perfect outfit today.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var usernameText: String {
        authViewModel.currentUser?.name ?? "there"
    }
    
    
    private var closetCard: some View {
        NavigationLink {
            Closet()
        } label: {
            HomeCard(
                title: "Your Closet",
                subtitle: "You have \(authViewModel.currentUser!.closet.count) item\(authViewModel.currentUser!.closet.count == 1 ? "" : "s") saved.",
                systemImage: "hanger"
            )
        }
        .buttonStyle(.plain)
    }
    
    // Recommendation Card
    
    private var recommendationCard: some View {
        NavigationLink {
            OutfitRecommendation()
        } label: {
            HomeCard(
                title: "Get Styled",
                subtitle: "Generate an outfit using your wardrobe.",
                systemImage: "sparkles"
            )
        }
        .buttonStyle(.plain)
    }
    
    
    private var quizCard: some View {
        NavigationLink {
            StyleQuizView()
        } label: {
            HomeCard(
                title: "Style Quiz",
                subtitle: "Tell us your style so future suggestions get better.",
                systemImage: "questionmark.circle"
            )
        }
        .buttonStyle(.plain)
    }
    
    
    private var tipCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tip of the Day")
                .font(.headline)
            Text("Start with a neutral base and add one accent color. This makes outfits easier to mix and match.")
                .font(.footnote)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 3, y: 2)
    }
}


struct HomeCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 3, y: 2)
    }
}


#Preview {
    let preview = Preview()
    preview.addUsers(User.sampleUser)
    preview.addClothingItems(ClothingItem.clothingItems)
    
    
    return HomeView()
        .modelContainer(preview.container).environmentObject({
            let vm = AuthViewModel()
            vm.currentUser = User.sampleUser[0]
            vm.isAuthenticated = true
            return vm
        }())
}
