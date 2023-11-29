import SwiftUI
import MapboxMaps

// Mapbox View Wrapper
struct MapboxView: UIViewRepresentable {
    var startCoordinate: CLLocationCoordinate2D
    var zoomLevel: Double
    
    func makeUIView(context: Context) -> MapView {
        let mapView = MapView(frame: .zero)
        // Set the initial camera position
        let cameraOptions = CameraOptions(center: startCoordinate, zoom: zoomLevel)
        mapView.mapboxMap.setCamera(to: cameraOptions)
        return mapView
    }

    func updateUIView(_ uiView: MapView, context: Context) {
        // Update the map view if needed, for example, if you want to change the start position dynamically
        let cameraOptions = CameraOptions(center: startCoordinate, zoom: zoomLevel)
        uiView.mapboxMap.setCamera(to: cameraOptions)
    }
}

// ContentView
struct ContentView: View {
    var body: some View {
        ZStack {
            MapboxView(
                startCoordinate: CLLocationCoordinate2D(latitude: 36.898439, longitude: 10.180634),
                zoomLevel: 11
            )
            .edgesIgnoringSafeArea(.all)
            
        } // END ZSTACK
        
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
