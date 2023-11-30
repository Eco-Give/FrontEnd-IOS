//
//  Reward.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//

import SwiftUI

struct RewardView: View {
    @State private var healthStore = HealthStore()
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
                    .padding(.top, 40)
                
                Spacer()
                StatsView()
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                        
                Spacer()
                BottomNavBar().padding(.bottom, 40)
            }
        }.task {
            await healthStore.requestAuthorization()
            do {
                print("Granted")
            } catch {
                print(error)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(HealthStore())
    }
}
struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
            
    }
}
