import SwiftUI
import MapKit // Import MapKit to use MKCoordinateRegion

struct FavoritesView: View {

    @ObservedObject var favoritesManager: FavoritesManager
    @Binding var region: MKCoordinateRegion // Binding to the mapView's region
    @Environment(\.presentationMode) var presentationMode // Environment variable to manage presentation mode

    var body: some View {
        NavigationView {
            List {
                ForEach(favoritesManager.favorites, id: \.id) { location in
                    Button(action: {
                        // Update the region to center on the selected favorite location
                        region.center = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
                        
                        // Close the sheet when a location is tapped
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(location.name) // Display the location name
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("Favorites", displayMode: .inline)
            .toolbar {
                EditButton()
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        favoritesManager.favorites.remove(atOffsets: offsets)
        // Update persistence if needed
    }
}
