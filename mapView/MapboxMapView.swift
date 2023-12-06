// MapboxMapView.swift

import SwiftUI
import MapboxMaps

struct MapboxMapView: UIViewRepresentable {
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
        //    pointAnnotation.image = .init(image: createDefaultMarker())
            pointAnnotation.textField = location.name // Set the title for the annotation
            annotations.append(pointAnnotation)
        }

        pointAnnotationManager.annotations = annotations
    }

    private func createDefaultMarker() -> UIImage {
        // Create a default marker image (red circle)
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()!

        context.setFillColor(UIColor.red.cgColor)
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(2)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.addEllipse(in: rect)
        context.drawPath(using: .fillStroke)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
