import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var currentRoute: MKRoute?
    var locations: [Location]  // Assuming Location is a struct representing your locations

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: true)
        mapView.delegate = context.coordinator
        updateAnnotations(for: mapView)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        updateAnnotations(for: uiView)
        updateRoute(for: uiView)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func updateAnnotations(for mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)  // Remove existing annotations
        let newAnnotations = locations.map { location -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            annotation.title = location.name  // Assuming your Location struct has a name
            // Add more properties to your annotation if needed
            return annotation
        }
        mapView.addAnnotations(newAnnotations)
    }

    private func updateRoute(for mapView: MKMapView) {
        if let currentRoute = currentRoute {
            mapView.addOverlay(currentRoute.polyline)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable

        init(_ parent: MapViewRepresentable) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = .blue
                renderer.lineWidth = 4
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }

        // Implement other delegate methods as needed
    }
}
