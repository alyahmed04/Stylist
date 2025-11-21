//
//  ContentView.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Closet()
    }
}

#Preview {
    //Learned and gotten from 'Handling user input' that was assigned in the 'Introducing SwiftUI' apple tutorial path
    //https://developer.apple.com/tutorials/swiftui/handling-user-input
    ContentView().environment(ModelData())
}
