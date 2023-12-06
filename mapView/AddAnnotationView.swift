//
//  addAnnotationView.swift
//  mapView
//
//  Created by bilel!dhf on 6/12/2023.
//

import SwiftUI
import MapKit

struct AddAnnotationView: View {
    @Binding var coordinate: CLLocationCoordinate2D
    @State private var annotationTitle: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Location Details")) {
                    TextField("Title", text: $annotationTitle)
                    Text("Latitude: \(coordinate.latitude)")
                    Text("Longitude: \(coordinate.longitude)")
                }
                Section {
                    Button("Add Annotation") {
                        // Implement your logic to send data to backend
                        // Dismiss the sheet after adding the annotation
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("New Annotation", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
