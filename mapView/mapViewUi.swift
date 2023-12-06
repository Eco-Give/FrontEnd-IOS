import SwiftUI
import MapboxMaps

struct MapboxMapView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MapView {
        let mapInitOptions = MapInitOptions()
        let mapView = MapView(frame: .zero, mapInitOptions: mapInitOptions)
        
        // Set the default camera position
             let centralParkCoordinate = CLLocationCoordinate2D(latitude: 40.7829, longitude: -73.9654)
             let cameraOptions = CameraOptions(center: centralParkCoordinate, zoom: 10)
             mapView.mapboxMap.setCamera(to: cameraOptions)
        
        return mapView
    }

    func updateUIView(_ uiView: MapView, context: Context) {
        // Update the view when SwiftUI state changes
    }
}
#Preview {
    MapboxMapView()
}
