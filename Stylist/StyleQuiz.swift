//
//  StyleQuiz.swift
//  
//
//  Created by Theo Tran on 11/15/25.
//


import SwiftUI

struct StyleQuizView: View {
    
    @State private var modelData = ModelData()
    @State private var style = ""
    @State private var fit = ""
    @State private var color = ""
    @State private var shoppingFreq = ""
    @State private var favoriteOutfit = ""
    
    let styleOptions = ["Casual", "Streetwear", "Professional", "Active"]
    let fitOptions = ["Tight", "Tailored", "Relaxed", "Oversized"]
    let colorChoices = ["Neutrals", "Dark tones", "Bright colors"]
    let shoppingOptions = ["Weekly", "Monthly", "Rarely"]
    
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
                
            
                // Submit button
                Button {
                    print("Saved quiz results!")
                    //create user
                    if var user = modelData.currentUser {
                        user.styleQuiz = StyleQuiz(
                            style: style,
                            fit: fit,
                            color: color,
                            shoppingFreq: shoppingFreq
                        )

                        modelData.currentUser = user
                    }
                    
                } label: {
                    Text("Finish")
                        .font(.headline)
                        .background(Color.blue)
                        .foregroundColor(.white)
                }
                
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
        }
    }
}

#Preview {
    StyleQuizView()
}
