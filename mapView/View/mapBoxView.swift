//
//  mapBoxView.swift
//  mapView
//
//  Created by bilel_dhf on 29/11/2023.
//

//
//  mapBoxView.swift
//  mapView
//
//  Created by bilel_dhf on 29/11/2023.
//

import SwiftUI
import MapboxMaps


struct mapBox: UIViewRepresentable {
    
    var startCoordinate: CLLocationCoordinate2D
    var zoomLevel: Double
    var annotations:[PointAnnotation]
    
    func makeUIView(context: Context) -> MapView {
        let mapView = MapView(frame: .zero)
        // Set the initial camera position
        let cameraOptions = CameraOptions(center: startCoordinate, zoom: zoomLevel)
        mapView.mapboxMap.setCamera(to: cameraOptions)
        addAnnotations(to:mapView)
        return mapView
    }
    
    private func addAnnotations(to mapView: MapView) {
        let annotationManager = mapView.annotations.makePointAnnotationManager()
        annotationManager.annotations = annotations
    }
    
    

    func updateUIView(_ uiView: MapView, context: Context) {
        // Update the map view if needed, for example, if you want to change the start position dynamically
        let cameraOptions = CameraOptions(center: startCoordinate, zoom: zoomLevel)
        uiView.mapboxMap.setCamera(to: cameraOptions)
        addAnnotations(to:uiView)
    }
}

////

///

struct mapBoxView: View {
    @State private var annotations: [PointAnnotation] = []

    private func fetchLocations() {
        NetworkManager.shared.getlocation { result in
            switch result {
            case .success(let locations):
                DispatchQueue.main.async {
                    print("bilel fetched location \(locations)")
                    // Update annotations
                    self.annotations = locations.map { location in
                        let annotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat,longitude:   location.long))
                        print("bilel lat : \(location.lat) long : \(location.long)")
                        //annotation.title = location.name // Optionally set the title of the annotation
                        return annotation
                    }
                    print("bilel Annotations : \(self.annotations)")
                }
            case .failure(let error):
                print("Error fetching locations: \(error)")
            }
        }
    }
    
    var body: some View {
        
            mapBox(
                startCoordinate: CLLocationCoordinate2D(latitude: 36.89776121741441, longitude: 10.183950889165658),
                zoomLevel: 15,
                annotations: annotations
            )
            .edgesIgnoringSafeArea(.all)
        
        .onAppear {
            fetchLocations()
         
        }
    }
    
}

struct mapBoxView_Previews: PreviewProvider {
    static var previews: some View {
        mapBoxView()
    }
}

