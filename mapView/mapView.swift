import SwiftUI
import MapKit

struct mapView: View {
    @StateObject private var locationFetcher = LocationFetcher()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @State private var selectedLocation: Location?
    @State private var searchText = ""
    @State private var showingAddAnnotationSheet = false
    @State private var newAnnotationCoordinate = CLLocationCoordinate2D()

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
