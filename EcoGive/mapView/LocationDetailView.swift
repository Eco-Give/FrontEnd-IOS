import SwiftUI
import MapKit

extension Color {
    static let main_green = Color(red: 62 / 255, green: 180 / 255, blue: 137 / 255)
    static let second_green = Color(red: 19 / 255, green: 177 / 255, blue: 86 / 255)
}

struct LocationDetailView: View {
    @State private var showToast = false
    @State private var toastMessage = ""

    @ObservedObject var locationFetcher: LocationFetcher
    var favoritesManager: FavoritesManager
    let location: Location

    var body: some View {
        ZStack(alignment: .top) {
            Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .foregroundColor(.main_green)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .overlay(
                            Text(location.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(),
                            alignment: .bottomLeading
                        )
                }
                
                Group {
                    DetailSection(icon: "mappin.and.ellipse", title: "Address", content: location.adresse)
                    DetailSection(icon: "info.circle", title: "Description", content: location.description)
                    DetailSection(icon: "tag", title: "Category", content: location.categorie)
                }
                .padding([.horizontal, .top])
                
                Button(action: {
                    locationFetcher.makeCall()
                }) {
                    HStack {
                                   Image(systemName: "phone.fill") // Call icon
                                       .foregroundColor(.white)
                                   Text("Call")
                                       .fontWeight(.semibold)
                               }
                               .frame(minWidth: 0, maxWidth: .infinity)
                               .frame(height: 44)
                               .background(Color.main_green)
                               .foregroundColor(.white)
                               .cornerRadius(8)
                           }
                           .padding(.horizontal)
                           .padding(.top, 16)
                
                Button(action: {
                              openMapsForDirections(to: location)
                          }) {
                              HStack {
                                  Image(systemName: "map.fill") // Navigation icon
                                      .foregroundColor(.white)
                                  Text("Start Navigation")
                                      .fontWeight(.semibold)
                              }
                              .frame(minWidth: 0, maxWidth: .infinity)
                              .frame(height: 44)
                              .background(Color.main_green)
                              .foregroundColor(.white)
                              .cornerRadius(8)
                          }
                          .padding(.horizontal)
                          .padding(.top, 16)
                
                Button(action: {
                    favoritesManager.addFavorite(location)
                    toastMessage = "\(location.name) has been added to favorites!"
                    withAnimation {
                        showToast = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showToast = false
                        }
                    }
                }) {
                    HStack {
                                       Image(systemName: "star.fill") // Favorite icon
                                           .foregroundColor(.white)
                                       Text("Add to Favorites")
                                           .fontWeight(.semibold)
                                   }
                                   .frame(minWidth: 0, maxWidth: .infinity)
                                   .frame(height: 44)
                                   .background(Color.main_green)
                                   .foregroundColor(.white)
                                   .cornerRadius(8)
                               }
                               .padding(.horizontal)
                               .padding(.bottom, 0)

                Spacer()
            }
            
            if showToast {
                Text(toastMessage)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                    .transition(.opacity)
                    .animation(.easeInOut, value: showToast)
            }
        }
        .padding(.bottom)
    }
    
    func openMapsForDirections(to destination: Location) {
        let destinationCoordinate = CLLocationCoordinate2D(latitude: destination.lat, longitude: destination.long)
        let placemark = MKPlacemark(coordinate: destinationCoordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = destination.name
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }

    @ViewBuilder
    private func DetailSection(icon: String, title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.second_green)
                Text(title)
                    .font(.headline)
            }
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}
