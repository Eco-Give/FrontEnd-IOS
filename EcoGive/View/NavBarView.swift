//
//  PlayPauseView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//

import SwiftUI

struct NavBarView: View {
    @State private var isMenuOpen: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RMainView()
                        .frame(width: geometry.size.width)
                        .offset(x: self.isMenuOpen ? geometry.size.width/2 : 0)
                        .disabled(self.isMenuOpen)
                    
                    if self.isMenuOpen {
                        RMenuView(isMenuOpen: $isMenuOpen)
                            .frame(width: geometry.size.width / 2)
                            .transition(.move(edge: .leading))
                    }
                }
            }
            .navigationBarItems(leading: Button(action: {
                withAnimation {
                    self.isMenuOpen.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
                    .padding(10)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
                    .cornerRadius(6)
            })
            
        }
    }
}

struct RMainView: View {
    var body: some View {
        StepCounterView()
    }
}

struct RMenuView: View {
    @Binding var isMenuOpen: Bool
    @State private var selection: Int?

    var body: some View {
        VStack(alignment: .leading) {
      
            
            // Use a List or manually created VStack for menu items
            List {
                NavigationLink(destination: StepCounterView(), tag: 1, selection: $selection) {
                    Label("StepCounter", systemImage: "figure.walk")
                }
                NavigationLink(destination: ActivityListView(), tag: 2, selection: $selection) {
                    Label("Activity", systemImage: "plus.circle.fill")
                }
                NavigationLink(destination: RankingView(), tag: 3, selection: $selection) {
                    Label("Ranking", systemImage: "medal")
                }
            
            }
            .listStyle(PlainListStyle())
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        //.background(Color(.systemGray6))
    }
}
#Preview {
    NavBarView()
}
