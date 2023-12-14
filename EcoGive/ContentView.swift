

import SwiftUI


struct ContentView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            NavBarView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            
            
            mapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("map")
                }
                .tag(1)
            RecContentView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Rec")
                }
                .tag(2)
            NewsDisplay()
                .tabItem {
                    Image(systemName: "square.fill")
                    Text("Rec")
                }
                .tag(3)
        }
        .foregroundColor(.green)
        .accentColor(.bottomColor2)
        .background(Color.white)
    }
        
    }
    
    

    



#Preview {
    ContentView()
}
