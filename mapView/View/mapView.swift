//
//  mapView.swift
//  mapView
//
//  Created by MacBook Pro on 1/12/2023.
//

// ContentView.swift

import SwiftUI

struct mapView: View {
    @State private var locations: [Location] = []

    var body: some View {
        MapboxMapView(locations: locations)
            .onAppear {
                LocationService.fetchLocations { fetchedLocations in
                    self.locations = fetchedLocations
                }
            }
    }
}

#Preview {
    mapView()
}
