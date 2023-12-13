//
//  Reward.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//

import SwiftUI

struct StepCounterView: View {
    
    @StateObject private var healthStore = HealthStore()
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Color.backgroundGradient,
                center: .bottomTrailing,
                startAngle: .degrees(170),
                endAngle: .degrees(270))
                .blur(radius: 70, opaque: true)
                    
            VStack {
                TopBarView()
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.top, 44)
                
                ProgressGoalView()
                    .padding(.top, 100)
                
                Spacer()
                StatsView()
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                        
                Spacer()
                
            }
        }.task {
            await healthStore.requestAuthorization()
           
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(HealthStore())
    }
}
struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        StepCounterView()

    }
}
