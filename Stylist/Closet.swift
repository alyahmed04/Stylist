//
//  Closet.swift
//  Stylist
//
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI
import SwiftData

struct Closet: View {
    
    //Removal of environmental variables from all corresponding files was the change made
    //Solution was gotten from claude
    //Original Code:
    // @Environment(ModelData.self) var modelData
    //Conversation:
    @State private var showFavoritesOnly = false
    @EnvironmentObject var authVM: AuthViewModel

    
    var body: some View {
        //navigation stack was learned through apple documentation
        
        NavigationStack{
            //List function use with row file was learned in the 'SwiftUI essentials Building lists and navigation' tutorial that was assigned in the 'Introducing SwiftUI' apple tutorial path
            if let user = authVM.currentUser {
                List {
                    
                    ForEach (user.closet) { clothingItem in
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
   
}

#Preview {
    //Code learned and gotten from:
    //https://www.youtube.com/watch?v=tZq4mvqH9Fg&t=1002s
    let preview = Preview()
    preview.addUsers(User.sampleUser)
    preview.addClothingItems(ClothingItem.clothingItems)
    
    return Closet().modelContainer(preview.container).environmentObject({
        let vm = AuthViewModel()
        vm.currentUser = User.sampleUser[0]
        vm.isAuthenticated = true
        return vm
    }())
}
