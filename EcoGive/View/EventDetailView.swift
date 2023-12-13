import SwiftUI

struct EventDetailView: View {
    @ObservedObject var eventViewModel: EventViewModel
    var event: Event
    
    @State private var isActionSheetPresented = false
    @State private var isScanning = false
    @State private var scannedCode: String? = nil
    @State private var isShowingQRCode = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Text(event.eventName ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .scaleEffect(1.2) // Add scale animation

                    AsyncImageView(url: "http://172.18.15.242:3000/\(event.image ?? "")")
                        .frame(width: 350, height: 250)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                        .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.turquoise1, lineWidth: 2))
                        .padding()
                        .rotationEffect(.degrees(isActionSheetPresented ? 360 : 0)) // Add rotation animation

                    Button(action: {
                        withAnimation {
                            isActionSheetPresented.toggle()
                        }
                    }) {
                        Image(systemName: "qrcode")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Color.turquoise1)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .padding()
                            .rotationEffect(.degrees(isActionSheetPresented ? 90 : 0)) // Add rotation animation
                    }
                    .actionSheet(isPresented: $isActionSheetPresented) {
                        ActionSheet(
                            title: Text("QR Code Options"),
                            buttons: [
                                .default(Text("Scan QR Code")) {
                                    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                                        return
                                    }
                                    
                                    withAnimation {
                                        isScanning.toggle()
                                        isActionSheetPresented.toggle()
                                    }
                                },
                                .default(Text("Display QR Code")) {
                                    withAnimation {
                                        isShowingQRCode.toggle()
                                    }
                                },
                                .cancel()
                            ]
                        )
                    }

                    if let scannedCode = scannedCode {
                        Text("Scanned Code: \(scannedCode)")
                            .font(.body)
                            .foregroundColor(.green)
                            .padding()
                            .transition(.slide) // Add slide animation
                    }

                    Text(event.eventDescription ?? "")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(15)

                    InfoRow(systemName: "calendar", title: "Event Date", value: event.eventDate ?? "")
                    InfoRow(systemName: "map", title: "Location", value: event.eventLocation ?? "")
                    InfoRow(systemName: "house", title: "Organization", value: event.organization ?? "")

                    Spacer()
                }
                .padding()
                .navigationBarTitle("Event Details", displayMode: .inline)
            }
            .sheet(isPresented: $isScanning) {
                if isScanning {
                    QRCodeScannerView(isScanning: $isScanning, onCodeScanned: { code in
                        self.scannedCode = code
                        isScanning = false
                    })
                    .edgesIgnoringSafeArea(.all)
                }
            }
            .sheet(isPresented: $isShowingQRCode) {
                AsyncImageView(url: "http://172.18.15.242:3000/\(event.qrcode ?? "")")
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
                    .padding()
            }
            .accentColor(Color.turquoise1) // Apply the specified color to the tab bar
        }
    }
}

struct InfoRow: View {
    var systemName: String
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(.turquoise1)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.body)
            }
            .padding(.leading, 10)
        }
        .padding(10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal, 15)
        .shadow(radius: 5)
    }
}
