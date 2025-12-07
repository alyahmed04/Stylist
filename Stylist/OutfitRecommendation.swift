//
//  OutfitRecommendation.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/17/25.
//

import SwiftUI

struct OutfitRecommendation: View {
    // access to closet and auth state
   // @Environment(ModelData.self) var modelData
    @EnvironmentObject var authVM: AuthViewModel
    
    @State var occasion: Occasion? = nil
    @State var fit: Fit? = nil
    @State var weather: String = ""
    @State var notes: String = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var recommendationText: String?
    
    //Learned from:
    //https://developer.apple.com/documentation/swiftui/colorpicker
    @State private var backgroundColor =
           Color(.sRGB, red: 1, green: 0.93, blue: 0.82)
    
    @State private var subheaderColor =
           Color(.sRGB, red: 0.40, green: 0.22, blue: 0.13)
    
    
    @State private var buttonColor =
        Color(.sRGB, red: 1, green: 0.85, blue: 0.62)
    
     var statusColor: Color {
        isSubmitDisabled == true ? .secondary : buttonColor
    }
    
    
    
    
    var body: some View {
       
        
        
        //Styling for form + navigation stack from
        //https://sarunw.com/posts/swiftui-form-styling/
        NavigationView{
            Form{
                if(recommendationText == nil){
                    //Section function for forms was seen (learned) in a Youtube Tutorial "Hacker with swift: Creating a form"
                    //https://www.hackingwithswift.com/books/ios-swiftui/creating-a-form
                    Section("Occasion"){
                        List{
                            Picker("Occasion: ", selection: $occasion) {
                                Text("Casual").tag(Occasion.casual as Occasion?)
                                Text("Smart Casual").tag(Occasion.smartCasual as Occasion?)
                                Text("Active").tag(Occasion.active as Occasion?)
                                Text("Business").tag(Occasion.business as Occasion?)
                                Text("Formal").tag(Occasion.formal as Occasion?)
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    Section("Fit"){
                        List{
                            Picker("Fit: ", selection: $fit) {
                                Text("Regular").tag(Fit.regular as Fit?)
                                Text("Relaxed").tag(Fit.relaxed as Fit?)
                                Text("Oversized").tag(Fit.oversized as Fit?)
                                Text("Slim").tag(Fit.slim as Fit?)
                            }
                            .pickerStyle(.menu)
                        }
                        
                    }
                    
                    Section("Weather"){
                        //Learned from Apple Picker Documentation
                        //https://developer.apple.com/documentation/SwiftUI/Picker
                        TextField("Enter Weather Condition (Required)", text: $weather)
                    }
                    
                    Section("Additonal Notes (Optional)"){
                        //Learned from hacking with swift
                        //https://www.hackingwithswift.com/books/ios-swiftui/selecting-dates-and-times-with-datepicker
                        TextField("Enter Notes", text: $notes)
                    }
                    
                    Section{
                        HStack{
                            Spacer()
                            //Disabled button feature learned from:
                            //https://www.hackingwithswift.com/books/ios-swiftui/validating-and-disabling-forms
                            
                            // CHANGED: NavigationLink -> Button that calls the LLM
                            Button {
                                
                                
                                generateRecommendation()
                                
                            } label: {
                                if isLoading {
                                    ProgressView()
                                } else {
                                    HStack{
                                        Image(systemName: "paperplane.fill")
                                        Text("Submit")
                                    }
                                }
                            }
                            .buttonStyle(.glassProminent)
                            .disabled(isSubmitDisabled).tint(statusColor)  // 🔹 NEW helper below
                            
                            Spacer()
                        }
                    }
                    
                    // show error from LLM
                    if let errorMessage = errorMessage {
                        Section("Error") {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                    }
                }
                
                // show recommendation text from LLM
                if let text = recommendationText {
                   
                    Section("Your Recommendation") {
                        Text(.init(text))
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    HStack{
                        Spacer()
                        Button{
                            recommendationText = nil
                        } label:{
                            Text("Ok")
                            
                        }.buttonStyle(.borderedProminent)
                        Spacer()
                    }
                    
                }
                
            }.foregroundColor(subheaderColor).scrollContentBackground(.hidden).background(backgroundColor).navigationTitle("Outfit Recommendation")

        }
        
    }
    
    private var isSubmitDisabled: Bool {
        isLoading ||
        occasion == nil ||
        fit == nil ||
        weather.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        authVM.currentUser!.closet.isEmpty
    }
    
    // call into our LLM
    private func generateRecommendation() {
        guard let occasion = occasion,
              let fit = fit else { return }
        
        errorMessage = nil
        recommendationText = nil
        isLoading = true
        
        LLM.shared.generateOutfitRecommendation(
            closet:  authVM.currentUser!.closet,
            occasion: occasion,
            fit: fit,
            weather: weather,
            notes: notes
        ) { result in
            isLoading = false
            switch result {
            case .success(let text):
                recommendationText = text
                authVM.lastRecommendation = text   // save it for HomeView or history
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    OutfitRecommendation()
        .environmentObject(AuthViewModel())// needed because we use @EnvironmentObject
}
