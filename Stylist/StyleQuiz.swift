//
//  StyleQuiz.swift
//
//
//  Created by Theo Tran on 11/15/25.
//

import SwiftUI

struct StyleQuizView: View {
    
    // Use the shared AuthViewModel from the environment,
    // just like HomeView / LoginView / etc.
    @EnvironmentObject var authVM: AuthViewModel
    
    // Quiz answers
    @State private var style = ""
    @State private var fit = ""
    @State private var color = ""
    @State private var shoppingFreq = ""
    @State private var favoriteOutfit = ""
    
    // Options
    let styleOptions = ["Casual", "Streetwear", "Professional", "Active"]
    let fitOptions = ["Tight", "Tailored", "Relaxed", "Oversized"]
    let colorChoices = ["Neutrals", "Dark tones", "Bright colors"]
    let shoppingOptions = ["Weekly", "Monthly", "Rarely"]
    
    // LLM state
    @State private var isLoading = false
    @State private var quizRecommendation: String?
    @State private var errorMessage: String?
    
    // Save quiz results into a StyleQuiz object (you can later store this on the user)
    private func saveQuizResults() -> StyleQuiz {
        let quiz = StyleQuiz(
            style: style,
            fit: fit,
            color: color,
            shoppingFreq: shoppingFreq
        )
        
        // If you later add something like:
        // authVM.updateUserStyleQuiz(quiz)
        // you can call it here.
        
        return quiz
    }
    
    // Call the LLM using the quiz answers (no closet)
    private func generateStyleQuizOutfits(from quiz: StyleQuiz) {
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
                
                Text("Style Quiz")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("Tell us about your style so we can recommend outfits you’ll love.")
                    .foregroundColor(.secondary)
                
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
                        Text(quizRecommendation)
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
                    .background((style.isEmpty || fit.isEmpty || color.isEmpty || shoppingFreq.isEmpty || isLoading) ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(style.isEmpty || fit.isEmpty || color.isEmpty || shoppingFreq.isEmpty || isLoading)
                
                Spacer()
            }
            .padding()
        }
    }
}

// Picker component
struct QuestionPicker: View {
    var title: String
    var options: [String]
    @Binding var selection: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
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
    StyleQuizView()
        .environmentObject(AuthViewModel())
}
