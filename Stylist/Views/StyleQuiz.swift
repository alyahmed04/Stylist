//
//  StyleQuiz.swift
//
//
//  Created by Theo Tran on 11/15/25.
//

import SwiftUI
import SwiftData


struct StyleQuizView: View {
    
    // Use the shared AuthViewModel from the environment,
    // just like HomeView / LoginView / etc.
    @EnvironmentObject var authVM: AuthViewModel
    
    // Quiz answers
    @State var style: String
    @State var fit: String
    @State var color:String
    @State var shoppingFreq: String
    @State var cost: String
    
    
    // Options
    let styleOptions = ["Casual", "Streetwear", "Professional", "Active"]
    let fitOptions = ["Tight", "Tailored", "Relaxed", "Oversized"]
    let colorChoices = ["Neutrals", "Dark tones", "Bright colors"]
    let shoppingOptions = ["Weekly", "Monthly", "Rarely"]
    let costOptions = ["Less than $50", "$50-100", "More than $100"]
    
    
    @State private var headerColor =
           Color(.sRGB, red: 0.32, green: 0.18, blue: 0.11)
    @State private var subheaderColor =
           Color(.sRGB, red: 0.40, green: 0.22, blue: 0.13)
    
    @State private var backgroundColor =
           Color(.sRGB, red: 1, green: 0.93, blue: 0.82)
    

    
    // LLM state
    @State private var isLoading = false
    @State private var quizRecommendation: String?
    @State private var errorMessage: String?
    
    // Save quiz results into a StyleQuiz object (you can later store this on the user)
    private func saveQuizResults() -> StylePreferences {
        let quiz = StylePreferences(
            style: style,
            fit: fit,
            color: color,
            shoppingFreq: shoppingFreq,
            cost: cost
        )
        
        
        
        // If you later add something like:
        // authVM.updateUserStyleQuiz(quiz)
        // you can call it here.
        
        return quiz
    }
    
    // Call the LLM using the quiz answers (no closet)
    private func generateStyleQuizOutfits(from quiz: StylePreferences) {
        isLoading = true
        errorMessage = nil
        quizRecommendation = nil
        
        LLM.shared.generateOutfitsFromStyleQuiz(quiz: quiz) { result in
            isLoading = false
            switch result {
            case .success(let text):
                quizRecommendation = text
                // Optional: store it so HomeView / others can reuse
                authVM.lastRecommendation = text
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                
                Text("Style Preferences")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top).foregroundStyle(headerColor)
                
                Text("Tell us about your style so we can recommend outfits you’ll love.")
                    .foregroundColor(subheaderColor)
                
                // Style preference
                QuestionPicker(
                    title: "How would you describe your style?",
                    options: styleOptions,
                    selection: $style
                )
                
                // Fit preference
                QuestionPicker(
                    title: "How do you like your clothes to fit?",
                    options: fitOptions,
                    selection: $fit
                )
                
                // Color palette
                QuestionPicker(
                    title: "Which color palette do you prefer?",
                    options: colorChoices,
                    selection: $color
                )
                
                // Shopping frequency
                QuestionPicker(
                    title: "How often do you shop for clothes?",
                    options: shoppingOptions,
                    selection: $shoppingFreq
                    )
                    
                QuestionPicker(
                    title: "What is your price range?",
                    options: costOptions,
                    selection: $cost
                )
                
                // Error message from LLM
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                // LLM-generated outfit ideas
                if let quizRecommendation {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Outfit Ideas Based on Your Quiz")
                            .font(.headline)
                        //Learned that Text can intpret markdown from
                        //https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-markdown-content-in-text
                        //Learned how to get variables to display markdown from:
                        //https://stackoverflow.com/questions/71484662/swiftui-text-markdown-support-for-string-variables-or-string-interpolation-not-w
                        Text(.init(quizRecommendation))
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                }
                
                // Submit / Finish button
                Button {
                    let quiz = saveQuizResults()
                    authVM.currentUser?.stylePreferences = quiz
                    generateStyleQuizOutfits(from: quiz)
                } label: {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Finish")
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background((style.isEmpty || fit.isEmpty || color.isEmpty || shoppingFreq.isEmpty || isLoading) ? Color.gray : .brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(style.isEmpty || fit.isEmpty || color.isEmpty || shoppingFreq.isEmpty || isLoading)
                
                Spacer()
            }
            .padding()
        }.background(backgroundColor)
    }
}

// Picker component
struct QuestionPicker: View {
    
    @State private var headerColor =
           Color(.sRGB, red: 0.32, green: 0.18, blue: 0.11)
    
    var title: String
    var options: [String]
    @Binding var selection: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline).foregroundStyle(headerColor)
            
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}


#Preview {
    let preview = Preview()
    preview.addUsers(User.sampleUser)
    preview.addClothingItems(ClothingItem.clothingItems)
    preview.addStylePreferences(StylePreferences.stylePreferences)
    
    
    return  StyleQuizView(style: "", fit: "", color: "", shoppingFreq: "", cost: "").modelContainer(preview.container).environmentObject({
        let vm = AuthViewModel()
        vm.currentUser = User.sampleUser[0]
        vm.isAuthenticated = true
        return vm
    }())
}
