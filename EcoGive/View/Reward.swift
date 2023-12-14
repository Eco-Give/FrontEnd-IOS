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
            
                    
            VStack {
                
                
                ProgressGoalView()
                    .padding(.top, 100)
                
                Spacer()
                StatsView()
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                        
                Spacer()
                
            }
            .background(Color(hex: 0xAFC8AD))
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
