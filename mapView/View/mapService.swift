import SwiftUI
import MapboxMaps

struct mapService: UIViewRepresentable {
    var locations: [Location]
    private var pointAnnotationManager: PointAnnotationManager?

    func makeUIView(context: Context) -> MapView {
        let mapView = MapView(frame: .zero)
        mapView.mapboxMap.loadStyleURI(.streets) { _ in
            self.pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
            self.addAnnotations(to: mapView)
        }
        return mapView
    }

    func updateUIView(_ uiView: MapView, context: Context) {
        // Update annotations if needed
    }

    private func addAnnotations(to mapView: MapView) {
        guard let pointAnnotationManager = self.pointAnnotationManager else { return }
        
        var annotations = [PointAnnotation]()
        for location in locations {
            var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long))
            
            // Set the image for the annotation
            // If you have a custom image asset, use UIImage(named:) to load it
          //  pointAnnotation.image = .init(image: UIImage(named: "") ?? .init())
            
            // Add a title if you wish to use the default callout
            pointAnnotation.textField = location.name // Use textField to set the title
            
            annotations.append(pointAnnotation)
        }
        
        pointAnnotationManager.annotations = annotations
    }
}
