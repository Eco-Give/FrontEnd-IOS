//
//  StatsView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//

import SwiftUI

struct StatsView: View {
    
    @EnvironmentObject var manager: HealthStore
    
    var body: some View {
        HStack {
            DataItemView(dataItem: manager.statData[0])
            Spacer()
                
            Rectangle()
                .fill(Color.white)
                .frame(width: 1, height: 200)
                .opacity(0.2)
                
            Spacer()
            DataItemView(dataItem: manager.statData[1])
            Spacer()
                
            Rectangle()
                .fill(Color.white)
                .frame(width: 1, height: 200)
                .opacity(0.2)
                
            Spacer()
            DataItemView(dataItem: manager.statData[2])
        }
    }
}
