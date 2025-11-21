//
//  AddTask.swift
//  TaskTrackerApp
//
//
//  Primary Device: iPhone 17
//
//  Created by Aly Ahmed on 10/9/25.
//

import SwiftUI

struct EditItem: View {
    @State private var clicked: Bool = false
    
   
    
    //Learned from Apple Binding and TA
    //https://developer.apple.com/documentation/swiftui/bindable
    @Binding var clothingItem: ClothingItem
    
    //Used as a copy to show current values and to enter new values. The purpose of this is to only make active changes when the user saves them not by entering them into the fields.
    @State var clothingItemCopy: ClothingItem
    
    
    @State private var cleanedName: String = ""
    @State private var cleanedBrand: String = ""
    
    
    //If the user has a valid title thats not spaces and the user enters a valid estimated time then a success message is show otherwise an error is shown
    var popup: String {
        cleanedName.isEmpty == false && cleanedBrand.isEmpty == false ? "Sucess!" : "Error!"
    }
    
    //Learned from Apple dismiss documentation and first discovered in bindable documentation
    //https://developer.apple.com/documentation/swiftui/environmentvalues/dismiss
    
    //Used to dismiss the view from the navigation stack under certain conditions
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        
        Form{
            
            //Section function for forms was seen (learned) in a Youtube Tutorial "Hacker with swift: Creating a form"
            //https://www.hackingwithswift.com/books/ios-swiftui/creating-a-form
            Section("Name"){
                //TextField learned from apple documentation
                //https://developer.apple.com/documentation/swiftui/textfield
                TextField("Enter Name", text: $clothingItemCopy.name)
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
                TextField("Enter Brand", text: $clothingItemCopy.brand)
            }
            
            Section("Notes"){
                //Learned from Apple Picker Documentation
                //https://developer.apple.com/documentation/SwiftUI/Picker
                TextField("Enter Item Notes", text: $clothingItemCopy.notes)
            }
            
            Section("Favorite Item"){
                //Learned from Apple Picker Documentation
                //https://developer.apple.com/documentation/SwiftUI/Picker
                Toggle("Favorite Item", isOn: $clothingItemCopy.isFavorite)
            }
                
                Section{
                    
                    //If the conditions of the form is met such as a valid title is typed and a valid estimated time is entered then the task will be added
                    //Otherwise it won't. No matter the condition clicked is toggled to display the form alert message
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
                            clothingItem.isFavorite = clothingItemCopy.isFavorite
                        }
                        clicked.toggle()
                        
                    }
                }
                
                
                //.alert and message functions (with use of isPresented field triggered by a button) for forms was learned in tutorial at "hacker with swift: Presenting an alert"
                //https://www.hackingwithswift.com/quick-start/swiftui/presenting-an-alert
        }.alert("\(popup)", isPresented: $clicked){
                
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
