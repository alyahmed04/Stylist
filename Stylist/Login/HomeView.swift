import SwiftUI
import SwiftData

struct HomeView: View {
    // Shared closet data
   // @Environment(ModelData.self) var modelData
    
    // Our existing auth view model
    @EnvironmentObject var authViewModel: AuthViewModel
    
    //Learned from:
    //https://developer.apple.com/documentation/swiftui/colorpicker
    @State private var headerColor =
           Color(.sRGB, red: 0.32, green: 0.18, blue: 0.11)
    @State private var subheaderColor =
           Color(.sRGB, red: 0.40, green: 0.22, blue: 0.13)
    
    @State private var backgroundColor =
           Color(.sRGB, red: 1, green: 0.93, blue: 0.82)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Greeting
                    headerSection
                    
                    // Closet summary
                 //   closetCard
                    
                    // Recommendation card
                    lastRecommendationCard
                    
                    // Style Quiz card
                    quizCard
                    
                    // Tip of the Day
                    tipCard
                    
                    settingsSection
                }
                .padding()
            }.background(backgroundColor)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hello, \(usernameText) 👋")
                .font(.largeTitle.bold()).foregroundStyle(headerColor)
            
            Text("Let’s build your perfect outfit today.")
                .font(.subheadline)
                .foregroundStyle(subheaderColor)
        }
    }
    
    private var usernameText: String {
        authViewModel.currentUser?.name ?? "there"
    }
    
    
    private var lastRecommendationCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Last Recommendation")
                .font(.headline).foregroundStyle(headerColor)
            
            if let lastRecommendation = authViewModel.lastRecommendation {
                //Learned that Text can intpret markdown from
                //https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-markdown-content-in-text
                //Learned how to get variables to display markdown from:
                //https://stackoverflow.com/questions/71484662/swiftui-text-markdown-support-for-string-variables-or-string-interpolation-not-w
                Text(.init(lastRecommendation))
                    .font(.footnote)
            } else {
                // Shown for a second while we wait for the API call to work
                Text("Naivigate to The Recommendation page to get your recommendation!")
                    .font(.footnote)
                    .foregroundStyle(subheaderColor)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 3, y: 2)
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
            .font(.headline).foregroundStyle(headerColor)
        
        if let tip = authViewModel.dailyTip {
            //Learned that Text can intpret markdown from
            //https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-markdown-content-in-text
            //Learned how to get variables to display markdown from:
            //https://stackoverflow.com/questions/71484662/swiftui-text-markdown-support-for-string-variables-or-string-interpolation-not-w
            Text(.init(tip))
                .font(.footnote)
        } else {
            // Shown for a second while we wait for the API call to work
            Text("Loading a style tip for you...")
                .font(.footnote)
                .foregroundStyle(subheaderColor)
        }
    }
    .padding()
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .shadow(radius: 3, y: 2)
}

    
    private var settingsSection: some View {
        VStack(spacing: 15) {
            // Biometric toggle
            if BiometricAuthManager.shared.isBiometricAvailable() {
                VStack(alignment: .leading, spacing: 12) {
                    Toggle(isOn: Binding(
                        get: { authViewModel.biometricAuthEnabled },
                        set: { enabled in
                            if enabled {
                                authViewModel.enableBiometricAuth()
                            } else {
                                authViewModel.disableBiometricAuth()
                            }
                        }
                    )) {
                        HStack {
                            Image(systemName: BiometricAuthManager.shared.biometricType() == .faceID ?
                                  "faceid" : "touchid")
                                .foregroundColor(.green)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Enable \(BiometricAuthManager.shared.biometricType() == .faceID ? "Face ID" : "Touch ID")")
                                    .font(.body)
                                Text("Quick login on next visit")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            
            // Logout button
            Button(action: {
                withAnimation {
                    authViewModel.logout()
                }
            }) {
                HStack {
                    Image(systemName: "arrow.right.square.fill")
                    Text("Logout")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.red)
                .cornerRadius(10)
            }
        }
    }

    
    
}



struct HomeCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    @State private var headerColor =
        Color(.sRGB, red: 0.32, green: 0.18, blue: 0.11)
    
    @State private var subheaderColor =
           Color(.sRGB, red: 0.40, green: 0.22, blue: 0.13)
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline).foregroundStyle(headerColor)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(subheaderColor)
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
