import SwiftUI
import MapKit


extension Color {
    static let main_green = Color(red: 62 / 255, green: 180 / 255, blue: 137 / 255)
    static let second_green = Color(red: 19 / 255, green: 177 / 255, blue: 86 / 255)
}
struct LocationDetailView: View {
    @ObservedObject var locationFetcher = LocationFetcher()
    let location: Location
    var body: some View {
        ZStack {
            // Background color for the entire sheet
            Color(.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 16) {
                // Header with a background image and location name overlay
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
                    
                    // You could add a background image if you have one
                    // Image("locationHeaderImage")
                    //     .resizable()
                    //     .scaledToFill()
                }
                
                // Detail sections with icons and text
                Group {
                    DetailSection(icon: "mappin.and.ellipse", title: "Address", content: location.adresse)
                    DetailSection(icon: "info.circle", title: "Description", content: location.description)
                    DetailSection(icon: "tag", title: "Category", content: location.categorie)
                    // Add more sections as needed
                }
                .padding([.horizontal, .top])
                
                // Call To Action Button
                Button(action: {
                    locationFetcher.makeCall()
                }) {
                    Text("Call")
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.main_green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                Spacer()
            }
        }
        .padding(.bottom)
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
