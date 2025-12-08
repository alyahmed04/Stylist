//
//  StylistApp.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI
import SwiftData

@main
struct StylistApp: App {
    
    //There was a small issue with the orginal code
    //Solution was provided for from Claude
    //Original code:
    // let preview = Preview()
//    @StateObject private var authViewModel = AuthViewModel()
//    var body: some Scene {
//        //Gotten from AI
//        WindowGroup {
//            ContentView()
//        }
//       
//    }.modelContainer(preview.container).environmentObject(authViewModel)
//    init() {
//        preview.addUsers(User.sampleUser)
//        preview.addClothingItems(ClothingItem.clothingItems)
//        }
//}
    //Conversation:
    
    //Code learned and gotten from:
    //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
    
    let preview = Preview()
    @StateObject private var authViewModel = AuthViewModel()
    var body: some Scene {
        
        WindowGroup {
            //Gotten from AI
            ContentView().modelContainer(preview.container).environmentObject(authViewModel)
        }
       
    }
    //Code learned and gotten from:
    //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
    init() {
        preview.addUsers(User.sampleUser)
        preview.addClothingItems(ClothingItem.clothingItems)
        preview.addStylePreferences(StylePreferences.stylePreferences)
        }
}
