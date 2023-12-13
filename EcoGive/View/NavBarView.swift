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

            
            ActivityListView()
                .tabItem {
                    Image(systemName: "gift.fill")
                    Text("Gift")
                }
            
                .tag(1)

            

            RankingView()
                .tabItem {
                    Image(systemName: "medal.fill")
                    Text("Medal")
                }
                .tag(2)
        }
        .accentColor(.bottomColor2)
        .background(Color.white)
    }
}


#Preview {
    NavBarView()
}
