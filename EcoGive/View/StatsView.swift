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
            DataItemView(dataItem: DataItem(imageName: "medal.fill", imageColor: Color.yellow, value: "7", unit: "Rank"))
            Spacer()
                
            Rectangle()
                .fill(Color.white)
                .frame(width: 1, height: 200)
                .opacity(0.2)
                
            Spacer()
            DataItemView(dataItem: DataItem(imageName: "star.fill", imageColor: Color.green, value: "--", unit: "Score"))
            Spacer()
                
            Rectangle()
                .fill(Color.white)
                .frame(width: 1, height: 200)
                .opacity(0.2)
                
            Spacer()
            DataItemView(dataItem: DataItem(imageName: "drop.fill", imageColor: Color.blue, value: "0", unit: "Mile"))
        }
    }
}
#Preview {
    StatsView()
}
