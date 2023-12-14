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
        .background(Color(hex: 0xAFC8AD))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.fetch()
        }
    }
}

#Preview {
    ActivityListView()
}
