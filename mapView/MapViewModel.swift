import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var searchText = ""
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    func fetchLocations() {
        // Your code to fetch locations goes here
    }
    
    func performSearch(query: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        searchRequest.region = region

        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let response = response {
                    self.locations = response.mapItems.compactMap { item in
                        // Conversion from MKMapItem to Location
                    }
                    // Update region to focus on the first result
                } else {
                    print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }

}
