//
//  map.swift
//  mapView
//
//  Created by bilel dhif on 28/11/2023.
//

import SwiftUI

struct map: View {
    @ObservedObject var ViewModel = LocationViewModel()
    
    var body: some View {
        VStack(spacing: 20.0) {
            
            VStack(){
                
                // Header with the name of the coffee shop
                Text("Corner Café")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                // Description of the coffee shop
                Text("rue imem sahnoun, 9170")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
                .frame(maxWidth: .infinity)
                .background(Color.blue)
             
                
            // ----- H-button ----
            HStack(spacing: 90) { // Adjust spacing as needed
                
                // Call button
                Button(action: {
                    // Perform call action
                }) {
                    VStack {
                        Image(systemName: "phone.fill") // Replace with your own image if needed
                            .foregroundColor(.purple)
                        Text("CALL")
                            .foregroundColor(.purple)
                            .font(.caption)
                    }
                }
                
                // Website button
                Button(action: {
                    // Perform website action
                }) {
                    VStack {
                        Image(systemName: "link") // Replace with your own image if needed
                            .foregroundColor(.purple)
                        Text("WEBSITE")
                            .foregroundColor(.purple)
                            .font(.caption)
                    }
                }
                
                // Save button
                Button(action: {
                    // Perform save action
                }) {
                    VStack {
                        Image(systemName: "bookmark.fill") // Replace with your own image if needed
                            .foregroundColor(.purple)
                        Text("SAVE")
                            .foregroundColor(.purple)
                            .font(.caption)
                    }
                }
                
            }
            // ----- END H-button ----
            
            // description
            Divider()
            Text(" description description description description description description description description")
                .padding(.horizontal)
                .font(.subheadline)
            
            Divider()
            // END description
            VStack(alignment: .leading,spacing: 8){
                HStack {
                    Image(systemName: "lovscation")
                        .foregroundColor(.secondary)
                    Text("3794 Pretty View Lane")
                        .foregroundColor(.primary)
                }
                HStack {
                    Image(systemName: "phone")
                        .foregroundColor(.secondary)
                    Text("(555) 555-1212")
                        .foregroundColor(.primary)
                }
                HStack() {
                    Image(systemName: "network")
                        .foregroundColor(.secondary)
                    Text("thecornercafe.biz")
                        .foregroundColor(.primary)
                }
                
            }
            List(ViewModel.location) {
               
                location in
                VStack{
                    Text(location.adresse)
                }
               


            }
            .onAppear{
                ViewModel.getlocation()
            }
            Button("close window"){}
                
            Spacer()
        }
      
}
    
    /*struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }*/
    
}
    
