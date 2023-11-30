//
//  PlayPauseView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//

import SwiftUI

struct BottomNavBar: View {
    

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(Color.white)
                .frame(width: 300, height: 70)
                .shadow(color: Color.black.opacity(0.5), radius: 20, x: 5.0, y: 15.0)
                
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.bottomColor2)
                        .frame(width: 60, height: 60)
                        
                    Image(systemName: "house.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                ZStack {
                    Circle()
                        .fill(Color.bottomColor2)
                        .frame(width: 60, height: 60)
                        
                    Image(systemName: "gift.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                ZStack {
                    Circle()
                        .fill(Color.bottomColor2)
                        .frame(width: 60, height: 60)
                        
                    Image(systemName: "flame.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                ZStack {
                    Circle()
                        .fill(Color.bottomColor2)
                        .frame(width: 60, height: 60)
                        
                    Image(systemName: "medal.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
            }.offset(x: -12)
        }
//        .onTapGesture {
//            manager.updateData()
//        }
    }
}
#Preview {
    BottomNavBar()
}
