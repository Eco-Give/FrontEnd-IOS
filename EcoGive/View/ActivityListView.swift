//
//  ActivityListView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 7/12/2023.
//

import SwiftUI

struct ActivityListView: View {
    @StateObject var viewModel = ActivityListViewModel()
    @State private var isBottomSheetPresented = false
    @State private var selectedActivity: Activity?
    
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Color.backgroundGradient,
                center: .bottomTrailing,
                startAngle: .degrees(170),
                endAngle: .degrees(270))
            .blur(radius: 70, opaque: true)
            
            
            
            VStack {
                Text("Activities")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 80)
                    .foregroundColor(.green)
                    
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1), content: {
                        ForEach(viewModel.activities, id: \.self) { activity in
                            ActivityItemView(activity: activity)
                                .onTapGesture {
                                    selectedActivity = activity
                                    isBottomSheetPresented.toggle()
                                }
                                .sheet(isPresented: $isBottomSheetPresented) {
                                    ActivityBottomSheetView(activity: selectedActivity ?? Activity(Desc: "", Reward: 0, Goal: ""))
                                }
                        }
                    })
                    .padding(.horizontal, 20) // Adjust horizontal padding
                   // .padding(.top, 100) // Add space at the top
                    .padding(.bottom, 40) // Adjust bottom padding
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.fetch()
        }
    }
}

#Preview {
    ActivityListView()
}
