//
//  ContentView.swift
//  Stylist
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Closet()
        }
        .padding()
    }
}

#Preview {
    ContentView().environment(ModelData())
}
