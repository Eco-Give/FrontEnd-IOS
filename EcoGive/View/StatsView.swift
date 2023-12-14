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
            DataItemView(dataItem: DataItem(imageName: "medal.fill", imageColor: Color.yellow, value: manager.userStat.Level, unit: "Rank"))
            Spacer()
                
            Rectangle()
                .fill(Color.white)
                .frame(width: 1, height: 200)
                .opacity(0.2)
                
            Spacer()
            DataItemView(dataItem: DataItem(imageName: "star.fill", imageColor: Color.green, value: manager.userStat.Score, unit: "Score"))
            Spacer()
                
            Rectangle()
                .fill(Color.white)
                .frame(width: 1, height: 200)
                .opacity(0.2)
                
            Spacer()
            DataItemView(dataItem: DataItem(imageName: "figure.walk", imageColor: Color.blue, value: manager.weeklyStepCount.formatted(), unit: "steps"))
        }
    }
}
#Preview {
    StatsView()
}
