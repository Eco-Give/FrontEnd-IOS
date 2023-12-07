/*import SwiftUI
import MapKit

struct CustomMapView: UIViewRepresentable {
    @ObservedObject var locationFetcher: LocationFetcher
    var locationManager: LocationManager
    var region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true // Show the user's location
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the map view with new annotations
        updateAnnotations(mapView: uiView)
    }
    
    private func updateAnnotations(mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations) // Remove existing annotations
        let annotations = locationFetcher.locations.map { location -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            annotation.title = location.name
            return annotation
        }
        mapView.addAnnotations(annotations)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CustomMapView

        init(_ parent: CustomMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
                view.image = UIImage(systemName: "location.circle.fill")
                view.tintColor = .blue
                return view
            }
            // Handle other annotations
            return nil
        }
    }
}

struct mapView: View {
    @StateObject private var locationFetcher = LocationFetcher()
    private let locationManager = LocationManager.shared
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

    var body: some View {
        CustomMapView(locationFetcher: locationFetcher, locationManager: locationManager, region: region)
            .ignoresSafeArea()
            .onAppear {
                locationManager.requestLocationAuthorization()
                locationManager.startUpdatingLocation()
                locationFetcher.fetchLocations()
                locationFetcher.locations
            }
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}

*/





/////////////////////
import SwiftUI
import MapKit
import CoreLocation


struct mapView: View {
    @StateObject private var locationFetcher = LocationFetcher()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @State private var selectedLocation: Location?
    @State private var searchText = ""
    @State private var showingAddAnnotationSheet = false
    @State private var newAnnotationCoordinate = CLLocationCoordinate2D()
    //@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    private let locationManager = CLLocationManager()

    
    
    // Function to request location access and start updating location
      private func setupLocationManager() {
          locationManager.requestWhenInUseAuthorization()
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
          locationManager.startUpdatingLocation()
      }
      
      // Function to update the region based on the user's location
      private func updateUserLocation() {
          if let location = locationManager.location {
              region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
          }
      }
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region, annotationItems: locationFetcher.locations) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)) {
                    
                    annotationView(for: location.categorie)
                        .onTapGesture {
                            self.selectedLocation = location
                        }
                }
            }
            .onAppear(perform: locationFetcher.fetchLocations)
         
            SearchBarView(searchText: $searchText, onSearch: searchLocation)
                .padding(.top, 50)
                .zIndex(1)

            .sheet(item: $selectedLocation) { location in
                LocationDetailView(location: location)
            }

        
        }
        .ignoresSafeArea(.all)
        .onAppear {
                  setupLocationManager()
                  updateUserLocation()
                  locationFetcher.fetchLocations()
              }
    }

    private func searchLocation() {
        if let location = locationFetcher.locations.first(where: { $0.name.lowercased().contains(searchText.lowercased()) }) {
            withAnimation {
                region.center = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            }
        }
    }

    @ViewBuilder
    private func annotationView(for category: String) -> some View {
        switch category {
        case "metal":
            Image("metal").resizable().scaledToFit().frame(width: 70, height: 70)
        case "plastic":
            Image("plastic").resizable().scaledToFit().frame(width: 70, height: 70)
        default:
            Image("food").resizable().scaledToFit().frame(width: 70, height: 70)
        }
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}

