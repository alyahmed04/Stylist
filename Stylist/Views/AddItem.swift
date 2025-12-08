//
//  AddItem.swift
//  Stylist
//
// This file allows the user to enter a new clothing item within their own personal closet. The file is navigated to from the add item navigation link on the closet page. The file enables users to enter required fields and either click save to add a new item or navigate out to not add a item.
//
//  Created by Aly Ahmed on 11/17/25.
//

import SwiftUI
import SwiftData

struct AddItem: View {
    @State private var clicked: Bool = false
    
    //Learned and gotten from 'Handling user input' that was assigned in the 'Introducing SwiftUI' apple tutorial path
    //https://developer.apple.com/tutorials/swiftui/handling-user-input
    @EnvironmentObject var authVM: AuthViewModel
   
    
    @State private var name: String = ""
    @State private var fit: Fit? = nil
    @State private var category: ClothingCategory? = nil
    @State private var mainColor: ColorFamily? = nil
    @State private var accentColor: ColorFamily? = ColorFamily.none
    @State private var brand: String = ""
    @State private var notes: String = ""
    
    
    @State private var cleanedName: String = ""
    @State private var cleanedBrand: String = ""
    
    
    //Learned from:
    //https://developer.apple.com/documentation/swiftui/colorpicker
    @State private var backgroundColor =
           Color(.sRGB, red: 1, green: 0.93, blue: 0.82)
    
    
    @State private var subheaderColor =
           Color(.sRGB, red: 0.40, green: 0.22, blue: 0.13)
    
    var popup: String {
        cleanedName.isEmpty == false && cleanedBrand.isEmpty == false && fit != nil && category != nil && mainColor != nil ? "Success!" : "Error!"
    }
    
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
                Section("Name (Required)"){
                    //TextField learned from apple documentation
                    //https://developer.apple.com/documentation/swiftui/textfield
                    TextField("Enter Name", text: $name)
                }
                Section("Fit (Required)"){
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
                
                Section("Category (Required)"){
                    //Learned from Apple Picker Documentation
                    //https://developer.apple.com/documentation/SwiftUI/Picker
                    List{
                        Picker("Clothing Category: ", selection: $category) {
                            Text("Top").tag(ClothingCategory.top)
                            Text("Outerwear").tag(ClothingCategory.outerwear)
                            Text("Bottom").tag(ClothingCategory.bottom)
                            Text("Footwear").tag(ClothingCategory.footwear)
                            Text("accessory").tag(ClothingCategory.accessory)
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                Section("Main Color (Required)"){
                    //Learned from hacking with swift
                    //https://www.hackingwithswift.com/books/ios-swiftui/selecting-dates-and-times-with-datepicker
                    List{
                        Picker("Main Color: ", selection: $mainColor) {
                            Text("White").tag(ColorFamily.white)
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
                
                Section("Accent Color (Required)"){
                    //Gotten from TA FAQ
                    List{
                        Picker("Accent Color: ", selection: $accentColor) {
                            Text("None").tag(ColorFamily.none)
                            Text("White").tag(ColorFamily.white)
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
                
                Section("Brand (Required)"){
                    //Learned from Apple Picker Documentation
                    //https://developer.apple.com/documentation/SwiftUI/Picker
                    TextField("Enter Brand (Required)", text: $brand)
                }
                
                Section("Notes (Optional)"){
                    //Learned from Apple Picker Documentation
                    //https://developer.apple.com/documentation/SwiftUI/Picker
                    TextField("Enter Item Notes", text: $notes)
                }
                
                
                Section{
                    HStack{
                        Spacer()
                        Button("Save changes") {
                            cleanedName = name.trimmingCharacters(in: .whitespaces)
                            cleanedBrand = brand.trimmingCharacters(in: .whitespaces)
                            let cleanedNotes = notes.trimmingCharacters(in: .whitespaces)
                            if(cleanedName.isEmpty == false && cleanedBrand.isEmpty == false && fit != nil && category != nil && mainColor != nil){
                                let clothingItem = ClothingItem(name: cleanedName, category: category!, mainColor: mainColor!, fit: fit!, notes: cleanedNotes, brand: brand)
                                authVM.currentUser!.closet.append(clothingItem)
                            }
                            clicked.toggle()
                            
                        }.buttonStyle(.borderedProminent).tint(.brown).foregroundStyle(.white)
                        Spacer()
                    }
                }
                
                
                //.alert and message functions (with use of isPresented field triggered by a button) for forms was learned in tutorial at "hacker with swift: Presenting an alert"
                //https://www.hackingwithswift.com/quick-start/swiftui/presenting-an-alert
            }.navigationTitle("Add Clothing Item").foregroundColor(subheaderColor).scrollContentBackground(.hidden).background(backgroundColor).alert("\(popup)", isPresented: $clicked){
                
                //Having a button in alert was learned in tutorial at "hacker with swift: how to show an alert"
                //https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-an-alert
                
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
   
    let preview = Preview()
    preview.addUsers(User.sampleUser)
    preview.addClothingItems(ClothingItem.clothingItems)

    return AddItem()
        .modelContainer(preview.container)
        .environmentObject({
            let vm = AuthViewModel()
            vm.currentUser = User.sampleUser[0]
            vm.isAuthenticated = true
            return vm
        }())
    
}
