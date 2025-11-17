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

struct AddItem: View {
    @State private var clicked: Bool = false
    
    //Learned and gotten from 'Handling user input' that was assigned in the 'Introducing SwiftUI' apple tutorial path
    //https://developer.apple.com/tutorials/swiftui/handling-user-input
    @Environment(ModelData.self) var modelData
   
    
    @State private var name: String = ""
    @State private var fit: Fit? = nil
    @State private var category: ClothingCategory? = nil
    @State private var mainColor: ColorFamily? = nil
    @State private var accentColor: ColorFamily? = nil
    @State private var brand: String = ""
    @State private var notes: String = ""
    @State private var favorite: Bool = false
    
    

    
    @State private var cleanedName: String = ""
    @State private var cleanedBrand: String = ""
    
    
    //If the user has a valid title thats not spaces and the user enters a valid estimated time then a success message is show otherwise an error is shown
    var popup: String {
        cleanedName.isEmpty == false && cleanedBrand.isEmpty == false && fit != nil && category != nil && mainColor != nil ? "Sucess!" : "Error!"
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
                TextField("Enter Name", text: $name)
            }
            Section("fit"){
                List{
                    Picker("Task Status: ", selection: $fit) {
                        Text("Not Started").tag(Fit.regular)
                        Text("In Progress").tag(Fit.relaxed)
                        Text("Completed").tag(Fit.oversized)
                        Text("Completed").tag(Fit.slim)
                    }
                    .pickerStyle(.menu)
                }
                
            }
            
            Section("Category"){
                //Learned from Apple Picker Documentation
                //https://developer.apple.com/documentation/SwiftUI/Picker
                List{
                    Picker("Task Status: ", selection: $category) {
                        Text("Not Started").tag(ClothingCategory.top)
                        Text("In Progress").tag(ClothingCategory.outerwear)
                        Text("Completed").tag(ClothingCategory.bottom)
                        Text("Completed").tag(ClothingCategory.footwear)
                        Text("Completed").tag(ClothingCategory.accessory)
                    }
                    .pickerStyle(.menu)
                }
            }
            
            Section("Main Color"){
                //Learned from hacking with swift
                //https://www.hackingwithswift.com/books/ios-swiftui/selecting-dates-and-times-with-datepicker
                List{
                    Picker("Main Color: ", selection: $mainColor) {
                        Text("Not Started").tag(ColorFamily.white)
                        Text("Not Started").tag(ColorFamily.black)
                        Text("Not Started").tag(ColorFamily.blue)
                        Text("Not Started").tag(ColorFamily.brown)
                        Text("Not Started").tag(ColorFamily.green)
                        Text("Not Started").tag(ColorFamily.orange)
                        Text("Not Started").tag(ColorFamily.pink)
                        Text("Not Started").tag(ColorFamily.purple)
                        Text("Not Started").tag(ColorFamily.red)
                        Text("Not Started").tag(ColorFamily.yellow)
                    }
                    .pickerStyle(.menu)
                }
            }
            
            Section("Accent Color"){
                //Gotten from TA FAQ
                List{
                    Picker("Accent Color: ", selection: $accentColor) {
                        Text("Not Started").tag(ColorFamily.white)
                        Text("Not Started").tag(ColorFamily.black)
                        Text("Not Started").tag(ColorFamily.blue)
                        Text("Not Started").tag(ColorFamily.brown)
                        Text("Not Started").tag(ColorFamily.green)
                        Text("Not Started").tag(ColorFamily.orange)
                        Text("Not Started").tag(ColorFamily.pink)
                        Text("Not Started").tag(ColorFamily.purple)
                        Text("Not Started").tag(ColorFamily.red)
                        Text("Not Started").tag(ColorFamily.yellow)
                    }
                    .pickerStyle(.menu)
                }
            }
            
            Section("Notes"){
                //Learned from Apple Picker Documentation
                //https://developer.apple.com/documentation/SwiftUI/Picker
                TextField("Item Notes:", text: $notes)
            }
            
            Section("Favorite Item"){
                //Learned from Apple Picker Documentation
                //https://developer.apple.com/documentation/SwiftUI/Picker
                Toggle("Favorite Item:", isOn: $favorite)
            }
                
                Section{
                    
                    //If the conditions of the form is met such as a valid title is typed and a valid estimated time is entered then the task will be added
                    //Otherwise it won't. No matter the condition clicked is toggled to display the form alert message
                    Button("Save changes") {
                        cleanedName = name.trimmingCharacters(in: .whitespaces)
                        cleanedBrand = brand.trimmingCharacters(in: .whitespaces)
                        let cleanedNotes = notes.trimmingCharacters(in: .whitespaces)
                        if(cleanedName.isEmpty == false && cleanedBrand.isEmpty == false && fit != nil && category != nil && mainColor != nil){
                            var clothingItem = ClothingItem(name: cleanedName, category: category!, mainColor: mainColor!, fit: fit!, notes: cleanedNotes, brand: brand, isFavorite: favorite)
                            if(accentColor != nil){
                                clothingItem = ClothingItem(name: cleanedName, category: category!, mainColor: mainColor!, accentColor: accentColor!, fit: fit!, notes: cleanedNotes, brand: brand, isFavorite: favorite)
                            }
                            modelData.clothingItems.append(clothingItem)
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
                    if(cleanedName.isEmpty == false && cleanedBrand.isEmpty == false && fit != nil && category != nil && mainColor != nil){
                        dismiss()
                    }
                }
                //These are potential messages that appear in the popup depending on certain conditions of the form when the user hits "save changes"
            }message: {
                
                if(cleanedName.isEmpty == true && cleanedBrand.isEmpty == true && fit == nil && category == nil && mainColor == nil){
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
    AddItem().environment(ModelData())
}
