//
//  addAnnotation.swift
//  mapView
//
//  Created by bilel_dhf on 29/11/2023.
//

import SwiftUI


struct addAnnotation: View {
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var instructions: String = ""
    @State private var address: String = ""
    @State private var description: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Name", text: $name)
            TextField("Category", text: $category)
            TextField("Instructions", text: $instructions)
            TextField("Address", text: $address)
            TextField("Description", text: $description)
            HStack {
                TextField("Latitude", text: $latitude)
                TextField("Longitude", text: $longitude)
            }
            Button("Submit") {
                // Handle the submit action
                // Dismiss the popup
                isPresented = false
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 8)
    }
}
