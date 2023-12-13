import SwiftUI
import CodeScanner
import URLImage

struct HomeView: View {
    @ObservedObject var organizationViewModel = OrganizationViewModel()
    @ObservedObject var eventViewModel = EventViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var scannedCode: String?
    @State private var isActionSheetPresented = false
    @State private var isScanning = false
    @State private var shouldNavigateToEventDetail = false
    @State private var isShowingQRCode = false  // Add this line

    init() {
        // Set the accentColor for the entire TabView
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.turquoise1)
        UITabBar.appearance().tintColor = UIColor(Color.turquoise1)
    }

    var body: some View {
        NavigationView {
            TabView {
                // Home Tab
                VStack {
                    // QR Code Popup Menu
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
                                .default(Text("View Scanned Code")) {
                                    withAnimation {
                                        if let scannedCode = scannedCode {
                                            print("Scanned Code: \(scannedCode)")
                                        }
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

                    // Featured Organizations Section
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(organizationViewModel.organizations) { organization in
                                    NavigationLink(destination: OrganizationDetailView(organization: organization)) {
                                        OrganizationRow(organization: organization)
                                            .frame(width: 210, height: 150)
                                            .cornerRadius(20)
                                    }
                                }
                                .padding(.horizontal, 15)
                            }
                        }
                    }

                    // Upcoming Events Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(eventViewModel.events) { event in
                                NavigationLink(destination: EventDetailView(eventViewModel: eventViewModel, event: event),
                                               isActive: $shouldNavigateToEventDetail) {
                                    EmptyView()
                                }
                                .hidden()

                                GeometryReader { geometry in
                                    EventCardHome(event: event)
                                        .cornerRadius(16)
                                        .scaleEffect(1.2)
                                        .onTapGesture {
                                            scannedCode = event.id
                                            shouldNavigateToEventDetail.toggle()
                                        }
                                }
                                .frame(width: 150, height: 400)
                                .padding()
                            }
                        }
                    }
                }
                .navigationBarTitle("Home")
                .onAppear {
                    organizationViewModel.fetchOrganizations()
                    eventViewModel.fetchEvents()
                }
                .sheet(isPresented: $isScanning) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Scan a QR Code") { result in
                            .switch result do {
                                case .success(let scannedCode):
                                    if let scannedCode = scannedCode as? String {
                                        print("Scanned Code: \(scannedCode)")
                                        if let scannedEvent = eventViewModel.events.first(where: { $0.id == scannedCode }) {
                                            eventViewModel.fetchEventDetails(eventID: scannedEvent.id)
                                            shouldNavigateToEventDetail.toggle()
                                        }
                                    }
                                case .failure(let error):
                                print("Fetching event details for event ID: \(eventID)")

                                }
                    }
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                        .font(.title)
                }

                // Events Tab
                NavigationView {
                    EventListView().background(Color.turquoise)
                }
                .tabItem {
                    Label("Events", systemImage: "calendar")
                        .font(.title)
                }

                // Organizations Tab
                NavigationView {
                    OrganizationListView().background(Color.turquoise)
                }
                .tabItem {
                    Label("Organizations", systemImage: "person.2.fill")
                        .font(.title)
                }
            }
            .accentColor(Color.turquoise1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
