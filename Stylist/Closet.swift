//
//  Closet.swift
//  Stylist
//
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI


struct Closet: View {
    @Environment(ModelData.self) var modelData
    @State private var showFavoritesOnly = false


    
    var body: some View {
        //navigation stack was learned through apple documentation
        
        NavigationStack{
            //List function use with row file was learned in the 'SwiftUI essentials Building lists and navigation' tutorial that was assigned in the 'Introducing SwiftUI' apple tutorial path
            List {
                ForEach (modelData.clothingItems) { clothingItem in
                    //seperator learned from
                    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-adjust-list-row-separator-visibility-and-color
                    ClosetRow(clothingItem: clothingItem).padding(.vertical).frame(maxWidth: .infinity, alignment: .center).listRowSeparator(.automatic).listRowSeparatorTint(.black)
            }
            }.navigationTitle("Closet").toolbar{
                NavigationLink{
                    AddItem()
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add Item")
                    }
                }.foregroundStyle(.blue)
            }
            
            
        }
    }
   
}

#Preview {
    Closet().environment(ModelData())
}
