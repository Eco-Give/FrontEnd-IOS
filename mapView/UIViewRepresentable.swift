//
//  UIViewRepresentable.swift
//  mapView
//
//  Created by bilel!dhf on 6/12/2023.
//

import Foundation
import MapKit
import SwiftUI

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var newAnnotationCoordinate: CLLocationCoordinate2D?
    var onTap: ((CLLocationCoordinate2D) -> Void)?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let longPressRecognizer = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(gesture:)))
        mapView.addGestureRecognizer(longPressRecognizer)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the view.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable

        init(_ parent: MapViewRepresentable) {
            self.parent = parent
        }

        @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                let location = gesture.location(in: gesture.view)
                let coordinate = (gesture.view as! MKMapView).convert(location, toCoordinateFrom: gesture.view)
                parent.onTap?(coordinate)
            }
        }
    }
}
