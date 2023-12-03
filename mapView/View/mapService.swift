//
//  mapView.swift
//  mapView
//
//  Created by MacBook Pro on 1/12/2023.
//

// MapboxMapView.swift

import SwiftUI
import Mapbox

struct MapboxMapView: UIViewRepresentable {
    var locations: [Location]

    func makeUIView(context: Context) -> MGLMapView {
        let mapView = MGLMapView(frame: .zero, styleURL: MGLStyle.streetsStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return mapView
    }

    func updateUIView(_ uiView: MGLMapView, context: Context) {
        updateAnnotations(for: uiView)
    }

    private func updateAnnotations(for mapView: MGLMapView) {
        mapView.removeAnnotations(mapView.annotations ?? [])

        let annotations = locations.map { location -> MGLPointAnnotation in
            let annotation = MGLPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            // Set other annotation properties if needed
            return annotation
        }

        mapView.addAnnotations(annotations)
    }
}
