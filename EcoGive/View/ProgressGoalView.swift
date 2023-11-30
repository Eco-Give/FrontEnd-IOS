//
//  ProgressGoalView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//

import SwiftUI

struct ProgressGoalView: View {
    
    @EnvironmentObject var manager: HealthStore
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(RadialGradient(gradient: Gradient(colors: [Color.black.opacity(0.2), Color.white.opacity(0.3)]), center: .center, startRadius: 80, endRadius: 300), lineWidth: 40)
                .frame(width: 260, height: 260)
                
            Circle()
                .trim(from: 0.0, to: manager.goalPercentage)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.bottomColor2, Color.red]), startPoint: .top, endPoint: .trailing), style: StrokeStyle(lineWidth: 40, lineCap: .round))
                .frame(width: 260, height: 260)
                .rotationEffect(.degrees(-90))
                .shadow(color: Color.bottomColor2, radius: 30)
                
            VStack(spacing: 12) {
                
                Text("Goal: \(getFormeattedInt(number: manager.stepData.goal))")
                    .font(.system(size: 18))
                Text("\(getFormeattedInt(number: manager.stepData.count))")
                    .font(.system(size: 56))
            }.foregroundColor(.white)
                .task {
                    print("Goal: \(getFormeattedInt(number: manager.stepData.goal))")
                    print("\(getFormeattedInt(number: manager.stepData.count))")
                }
        }
    }
        
    func getFormeattedInt(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        return formatter.string(from: NSNumber(value: number))!
    }
    
}
