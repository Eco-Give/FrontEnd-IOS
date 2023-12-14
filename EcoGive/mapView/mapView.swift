import SwiftUI
import MapKit
import CoreLocation

struct mapView: View {
    @State private var showingFavorites = false
    @StateObject private var locationFetcher = LocationFetcher()
    @StateObject private var favoritesManager = FavoritesManager()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @State private var selectedLocation: Location?
    @State private var searchText = ""

    private let locationManager = CLLocationManager()

    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    private func updateUserLocation() {
        if let location = locationManager.location {
            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locationFetcher.locations) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)) {
                    annotationView(for: location.categorie)
                        .onTapGesture {
                            self.selectedLocation = location
                        }
                }
            }
            .onAppear(perform: locationFetcher.fetchLocations)

            HStack {
                SearchBarView(searchText: $searchText, onSearch: searchLocation)
                    .zIndex(1)

                Button(action: {
                    showingFavorites.toggle()
                }) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .padding()
                        .background(Color.main_green)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(radius: 5)
                }
                .sheet(isPresented: $showingFavorites) {
                    FavoritesView(favoritesManager: favoritesManager, region: $region)
                }
                .padding()
            }
            .padding(.top, 50)

            .sheet(item: $selectedLocation) { location in
                LocationDetailView(locationFetcher: locationFetcher, favoritesManager: favoritesManager, location: location)
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
