//
//  EditItem.swift
//  Stylist
//
//
//
//  Created by Aly Ahmed on 11/20/25.
//

import SwiftUI

struct EditItem: View {
    @State private var clicked: Bool = false
    
   
    //Removal of environmental variables from all corresponding files was the change made
    //Solution was gotten from claude
    //Original Code:
    // @Environment(ModelData.self) var modelData
    //Conversation:
    
    //Learned from Apple Binding and TA
    //https://developer.apple.com/documentation/swiftui/bindable
    @State var clothingItem: ClothingItem
    
    //Used as a copy to show current values and to enter new values. The purpose of this is to only make active changes when the user saves them not by entering them into the fields.
    @State var clothingItemCopy: ClothingItem
    
    
    @State private var cleanedName: String = ""
    @State private var cleanedBrand: String = ""
    
    
    
    var popup: String {
        cleanedName.isEmpty == false && cleanedBrand.isEmpty == false ? "Sucess!" : "Error!"
    }
    
    //Learned from:
    //https://developer.apple.com/documentation/swiftui/colorpicker
    @State private var backgroundColor =
           Color(.sRGB, red: 1, green: 0.93, blue: 0.82)
    
    @State private var subheaderColor =
           Color(.sRGB, red: 0.40, green: 0.22, blue: 0.13)
    
    @State private var buttonColor =
           Color(.sRGB, red: 1, green: 0.85, blue: 0.62)
    
    
    
    //Learned from Apple dismiss documentation and first discovered in bindable documentation
    //https://developer.apple.com/documentation/swiftui/environmentvalues/dismiss
    
    //Used to dismiss the view from the navigation stack under certain conditions
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        //Form Styling Learned from:
        //https://sarunw.com/posts/swiftui-form-styling/
        Form{
            
            //Section function for forms was seen (learned) in a Youtube Tutorial "Hacker with swift: Creating a form"
            //https://www.hackingwithswift.com/books/ios-swiftui/creating-a-form
            Section("Name"){
                //TextField learned from apple documentation
                //https://developer.apple.com/documentation/swiftui/textfield
                TextField("Enter Name (Required)", text: $clothingItemCopy.name)
            }
            Section("Fit"){
                List{
                    Picker("Fit: ", selection: $clothingItemCopy.fit) {
                        Text("Regular").tag(Fit.regular)
                        Text("Relaxed").tag(Fit.relaxed)
                        Text("Oversized").tag(Fit.oversized)
                        Text("Slim").tag(Fit.slim)
                    }
                    .pickerStyle(.menu)
                }
                
            }
            
            Section("Category"){
                //Learned from Apple Picker Documentation
                //https://developer.apple.com/documentation/SwiftUI/Picker
                List{
                    Picker("Clothing Category: ", selection: $clothingItemCopy.category) {
                        Text("Top").tag(ClothingCategory.top)
                        Text("Outerwear").tag(ClothingCategory.outerwear)
                        Text("Bottom").tag(ClothingCategory.bottom)
                        Text("Footwear").tag(ClothingCategory.footwear)
                        Text("accessory").tag(ClothingCategory.accessory)
                    }
                    .pickerStyle(.menu)
                }
            }
            
            Section("Main Color"){
                //Learned from hacking with swift
                //https://www.hackingwithswift.com/books/ios-swiftui/selecting-dates-and-times-with-datepicker
                List{
                    Picker("Main Color: ", selection: $clothingItemCopy.mainColor) {
                        Text("White").tag(ColorFamily.white)
                        Text("None").tag(ColorFamily.none)
                        Text("Black").tag(ColorFamily.black)
                        Text("Blue").tag(ColorFamily.blue)
                        Text("Brown").tag(ColorFamily.brown)
                        Text("Green").tag(ColorFamily.green)
                        Text("Orange").tag(ColorFamily.orange)
                        Text("Pink").tag(ColorFamily.pink)
                        Text("Purple").tag(ColorFamily.purple)
                        Text("Red").tag(ColorFamily.red)
                        Text("Yellow").tag(ColorFamily.yellow)
                    }
                    .pickerStyle(.menu)
                }
            }
            
            Section("Accent Color"){
                //Gotten from TA FAQ
                List{
                    Picker("Accent Color: ", selection: $clothingItemCopy.accentColor) {
                        Text("None").tag(ColorFamily.none)
                        Text("Black").tag(ColorFamily.black)
                        Text("Blue").tag(ColorFamily.blue)
                        Text("Brown").tag(ColorFamily.brown)
                        Text("Green").tag(ColorFamily.green)
                        Text("Orange").tag(ColorFamily.orange)
                        Text("Pink").tag(ColorFamily.pink)
                        Text("Purple").tag(ColorFamily.purple)
                        Text("Red").tag(ColorFamily.red)
                        Text("Yellow").tag(ColorFamily.yellow)
                        Text("White").tag(ColorFamily.white)
                    }
                    .pickerStyle(.menu)
                }
            }
            
            Section("Brand"){
                //Learned from Apple Picker Documentation
                //https://developer.apple.com/documentation/SwiftUI/Picker
                TextField("Enter Brand (Required)", text: $clothingItemCopy.brand)
            }
            
            Section("Notes"){
                //Learned from Apple Picker Documentation
                //https://developer.apple.com/documentation/SwiftUI/Picker
                TextField("Enter Item Notes", text: $clothingItemCopy.notes)
            }
            
            
                
                Section{
                    
                    HStack{
                        Spacer()
                        Button("Save changes") {
                            cleanedName = clothingItemCopy.name.trimmingCharacters(in: .whitespaces)
                            cleanedBrand = clothingItemCopy.brand.trimmingCharacters(in: .whitespaces)
                            let cleanedNotes = clothingItemCopy.notes.trimmingCharacters(in: .whitespaces)
                            if(cleanedName.isEmpty == false && cleanedBrand.isEmpty == false){
                                clothingItem.name = clothingItemCopy.name
                                clothingItem.category = clothingItemCopy.category
                                clothingItem.fit = clothingItemCopy.fit
                                clothingItem.mainColor = clothingItemCopy.mainColor
                                clothingItem.accentColor = clothingItemCopy.accentColor
                                clothingItem.brand = clothingItemCopy.brand
                                clothingItem.notes = cleanedNotes
                            }
                            clicked.toggle()
                            
                        }.buttonStyle(.borderedProminent).tint(buttonColor)
                        Spacer()
                    }
                }
                
                
                //.alert and message functions (with use of isPresented field triggered by a button) for forms was learned in tutorial at "hacker with swift: Presenting an alert"
                //https://www.hackingwithswift.com/quick-start/swiftui/presenting-an-alert
        }.navigationTitle("Edit Clothing Item").foregroundColor(subheaderColor).scrollContentBackground(.hidden).background(backgroundColor).alert("\(popup)", isPresented: $clicked){
                
                //Having a button in alert was learned in tutorial at "hacker with swift: how to show an alert"
                //https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-an-alert
                
                //This button dismisses the page from the navigation stack only if the input by the user is valid and they hit the saved changes button first
                Button("ok"){
                    
                    if(cleanedName.isEmpty == false && cleanedBrand.isEmpty == false){
                        dismiss()
                    }
                }
                //These are potential messages that appear in the popup depending on certain conditions of the form when the user hits "save changes"
            }message: {
                
                if(cleanedName.isEmpty == true || cleanedBrand.isEmpty == true){
                    Text("Please fill out fields complete!").font(.title)
                }
                else{
                    Text("Task Successfully Added!")
                }
                
                
            }
            
            
            
        }
    }


#Preview {
    //Learned and gotten from 'Handling user input' that was assigned in the 'Introducing SwiftUI' apple tutorial path
    //https://developer.apple.com/tutorials/swiftui/handling-user-input
    //EditItem().environment(ModelData())
}
