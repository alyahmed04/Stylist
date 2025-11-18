//
//  OutfitRecommendation.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/17/25.
//

import SwiftUI

struct OutfitRecommendation: View {
    @State var occasion: Occasion? = nil
    @State var fit: Fit? = nil
    @State var weather: String = ""
    @State var notes: String = ""
    @State var cleanedWeather: String = ""
    
    //Learned from
    //https://swiftontap.com/navigationlink
    struct SampleView: View {
            var body: some View {
                VStack{
                    
                }.navigationTitle("Your Recommendation")
                
                   
            }
        }
    
    var body: some View {
       
       //Styling for form + navigation stack from
        //https://sarunw.com/posts/swiftui-form-styling/
        NavigationView{
            Form{
                //Section function for forms was seen (learned) in a Youtube Tutorial "Hacker with swift: Creating a form"
                //https://www.hackingwithswift.com/books/ios-swiftui/creating-a-form
                Section("Occasion"){
                    List{
                        Picker("Occasion: ", selection: $occasion) {
                            Text("Casual").tag(Occasion.casual)
                            Text("Smart Casual").tag(Occasion.smartCasual)
                            Text("Active").tag(Occasion.active)
                            Text("Business").tag(Occasion.business)
                            Text("Formal").tag(Occasion.formal)
                        }
                        .pickerStyle(.menu)
                    }
                }
                Section("Fit"){
                    List{
                        Picker("Fit: ", selection: $fit) {
                            Text("Regular").tag(Fit.regular)
                            Text("Relaxed").tag(Fit.relaxed)
                            Text("Oversized").tag(Fit.oversized)
                            Text("Slim").tag(Fit.slim)
                        }
                        .pickerStyle(.menu)
                    }
                    
                }
                
                Section("Weather"){
                    //Learned from Apple Picker Documentation
                    //https://developer.apple.com/documentation/SwiftUI/Picker
                    TextField("Enter Weather Condition", text: $weather)
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
                        NavigationLink (destination: SampleView()){
                            HStack{
                                Image(systemName: "paperplane.fill").foregroundStyle(.blue)
                                Text("Submit").foregroundStyle(.blue)
                            }
                        }
                            .buttonStyle(.glassProminent).disabled(occasion == nil || fit == nil || weather.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true).buttonStyle(.glassProminent)
                        Spacer()
                    }
                }
                
            }.navigationTitle("Outfit Recommendation")
        }
        
    }
}

#Preview {
    OutfitRecommendation()
}
