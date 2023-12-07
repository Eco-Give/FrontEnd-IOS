//
//  PlayPauseView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//

import SwiftUI

struct NavBarView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            StepCounterView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            // Add other views for different tabs
           ActivityListView()
                .tabItem {
                    Image(systemName: "gift.fill")
                    Text("Gift")
                }
            
                .tag(1)

            Text("Other Tab 2")
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Flame")
                }
                .tag(2)

            Text("Other Tab 3")
                .tabItem {
                    Image(systemName: "medal.fill")
                    Text("Medal")
                }
                .tag(3)
        }
        .accentColor(.bottomColor2)
        .background(Color.white)
    }
}


#Preview {
    NavBarView()
}
