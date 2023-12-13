//
//  ContentView.swift
//  EcoGive
//
//  Created by oumayma cherif on 24/11/2023.
//

import SwiftUI


struct ContentView: View {
    @State var presentSideMenu = false
    
    var body: some View {
        
        ZStack {
            
            
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
              //  Text("hello")
                NavBarView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    
                    HStack {
                        Button {
                            presentSideMenu.toggle()
                        } label: {
                            Image(systemName: "house")
                                
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .foregroundColor(.white)
                      
                        .padding()
                        
                        Spacer()
                    }
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    
                    .zIndex(1)
                    .shadow(radius: 0.3)
                , alignment: .top)
            .background(Color.gray.opacity(0.8))
            
            SideMenu()
        }
        
        .frame(maxWidth: .infinity)
        
    }
    
    
    @ViewBuilder
    private func SideMenu() -> some View {
        SideView(isShowing: $presentSideMenu, direction: .leading) {
            SideMenuViewContents(presentSideMenu: $presentSideMenu)
                .frame(width: 300)
        }
    }
    
}


#Preview {
    ContentView()
}
