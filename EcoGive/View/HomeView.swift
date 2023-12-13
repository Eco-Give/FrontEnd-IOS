import SwiftUI

struct HomeView: View {
    @ObservedObject var organizationViewModel = OrganizationViewModel()
    @ObservedObject var eventViewModel = EventViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        // Set the accentColor for the entire TabView
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.turquoise1)
        UITabBar.appearance().tintColor = UIColor(Color.turquoise1)
    }
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    // Featured Organizations Section
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 1) {
                                ForEach(organizationViewModel.organizations) { organization in
                                    NavigationLink(destination: OrganizationDetailView(organization: organization)) {
                                        GeometryReader { geometry in
                                            OrganizationRow(organization: organization)
                                                .frame(width: 210, height: 150)
                                                .padding(.horizontal, 0)
                                                .cornerRadius(20)
                                                .rotation3DEffect(Angle(degrees:
                                                                            Double(geometry.frame(in: .global).minX - 45) / -15
                                                                       ), axis: (x: 0, y: 10.0, z: 0))
                                        }
                                        .frame(width: 180, height: 200)
                                    }
                                }
                               // .padding(.horizontal)
                            }
                          //  .frame(height: 200)
                        }
                        
                    }
                        // Upcoming Events Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 1) {
                            ForEach(eventViewModel.events) { event in
                                NavigationLink(destination: EventDetailView(eventViewModel: eventViewModel, event: event)) {
                                    GeometryReader { geometry in
                                        EventCardHome(event: event)
                                            .preferredColorScheme(colorScheme)
                                            .cornerRadius(16)
                                            .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -12), axis: (x: 0, y: 10.0, z: 0))
                                            .scaleEffect(x: 1.2, y: 1.2, anchor: .center)
                                    }
                                    .frame(width: 150, height: 150)
                                 // Adjust the width based on your design
                                }
                            }
                            .padding()
                        }
                    }



                    }
                    .navigationBarTitle("Home")
                    .onAppear {
                        organizationViewModel.fetchOrganizations()
                        eventViewModel.fetchEvents()
                    }
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                        .font(.title)
                }
                
                NavigationView {
                    EventListView().background(Color.turquoise)
                }
                .tabItem {
                    Label("Events", systemImage: "calendar")
                        .font(.title)
                }
                
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
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }

