//
//  ClosetRow.swift
//  Stylist
//
//
//  Created by Aly Ahmed on 11/15/25.
//

import SwiftUI


struct ClosetRow: View {
    
    @Environment(ModelData.self) var modelData
    @EnvironmentObject var authVM: AuthViewModel
    @State var clothingItem: ClothingItem
    @State private var isShowingSheet = false
    @State private var isConfirming = false
    
    var clothingIndex: Int {
            authVM.clothingItems.firstIndex(where: { $0.id == clothingItem.id })!
       }
    

    
    var body: some View {
        
        @Bindable var authVM = authVM
        
        //Learned how to make a copy for class objects and code snippet below from
        //https://www.hackingwithswift.com/example-code/system/how-to-copy-objects-in-swift-using-copy
        var clothingItemCopy = clothingItem.copy() as! ClothingItem
        
        NavigationStack{
            VStack(alignment: .leading, spacing: 12) {
                
                //Image was learned from 'Handling user input' tutorial that was assigned in the 'Introducing SwiftUI' apple tutorial path
                if authVM.clothingItems[clothingIndex].category == .top{
                    //image from
                    //https://timvandevall.com/templates/blank-t-shirt-templates/
                    Image("blank-tshirt-template").resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else if authVM.clothingItems[clothingIndex].category == .outerwear{
                    //image from
                    //https://www.freepik.com/free-photos-vectors/jacket-sketch/2#uuid=fdbb9f22-7cdc-420e-9e18-ac2fd29a606b
                    Image("10775876").resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else if(authVM.clothingItems[clothingIndex].category == .bottom){
                    //image from
                    //https://www.freepik.com/free-photos-vectors/pants-flat-sketch
                    
                    //learned about scale effect from
                    //https://stackoverflow.com/questions/78513189/how-to-scale-an-image-in-swiftui
                    Image("bottom").resizable()
                        .aspectRatio(contentMode: .fit).scaleEffect(0.75)
                }
                else if(authVM.clothingItems[clothingIndex].category == .accessory){
                    //image from
                    //https://www.freepik.com/free-photos-vectors/hat-drawing/2#uuid=8b0a1af1-2558-47f4-aa10-d2740ae4f647
                    Image("hat").resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else if(authVM.clothingItems[clothingIndex].category == .footwear){
                    //image from
                    //https://www.freepik.com/free-photos-vectors/shoe-drawing
                    Image("shoe").resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else{
                    Image(systemName: "hanger")
                }
                Text(authVM.clothingItems[clothingIndex].name).font(.headline)
                Text("Fit: \(authVM.clothingItems[clothingIndex].fit.rawValue)").font(.headline)
                Text("Color: \(authVM.clothingItems[clothingIndex].mainColor.rawValue)").font(.headline)
                
                if(authVM.clothingItems[clothingIndex].notes.isEmpty == false){
                    Text("Notes: \(authVM.clothingItems[clothingIndex].notes)").font(.headline)
                    Spacer()
                }
                
                HStack{
                    
                    //Button learned from previous assignments
                    //confirmation dilago learned from
                    //https://www.hackingwithswift.com/books/ios-swiftui/showing-multiple-options-with-confirmationdialog
                    //https://developer.apple.com/documentation/swiftui/view/confirmationdialog(_:ispresented:titlevisibility:presenting:actions:)-9ibgk
                    
                    
                    
                    Button("Remove", systemImage: "trash"){
                        isConfirming = true
                    }.foregroundColor(.white).tint(.red).buttonStyle(.glassProminent).confirmationDialog(
                        "Are you sure you want to remove?",
                        isPresented: $isConfirming
                    ) {
                        Button {
                            authVM.clothingItems.remove(at: clothingIndex)
                        } label: {
                            Text("""
                        Remove \(clothingItem.name)
                        """)
                        }
                        Button("Cancel") {
                            isConfirming = false
                        }
                    } message: {
                        Text("Are you sure you want to remove?")
                    }
                    Spacer()
                    Spacer()
                    NavigationLink{
                        EditItem(clothingItem: $authVM.clothingItems[clothingIndex], clothingItemCopy: clothingItemCopy)
                    }   label:{
                        HStack{
                            Image(systemName: "pencil").foregroundStyle(.blue)
                            Text("edit").foregroundStyle(.blue)
                        }
                    }.buttonStyle(.bordered).frame(maxWidth: 80)
                    
                    
                }
                
                
                
                
            }
        }
    }
    

}


#Preview {
//    let modelData = ModelData()
//        return ClosetRow(clothingItem: modelData.clothingItems[0])
//            .environment(modelData)
}
