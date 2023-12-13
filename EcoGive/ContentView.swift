//
//  ContentView.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//
import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("1")
                        .resizable()
                        .frame(width: 296, height: 324)
                        .padding(.bottom, 140)
                        .scaleEffect(isActive ? 1.0 : 1.0)
                    
                    Text("Welcome to Eco Give")
                        .font(.custom("AlmondNougat", size: 24))
                        .foregroundColor(.turquoise1)
                        .opacity(isActive ? 1.0 : 1.2)
                        .padding()
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isActive = true
                        }
                    }
                }
                .navigationBarHidden(true)
                .background(
                    NavigationLink(
                        destination: HomeView(),
                        isActive: $isActive,
                        label: {
                            EmptyView()
                        }
                    )
                    .isDetailLink(false)
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let turquoise = Color(red: 0.0, green: 0.8, blue: 0.8)
    static let turquoise1 = Color(red: 0.0, green: 0.5, blue: 0.5)
}
