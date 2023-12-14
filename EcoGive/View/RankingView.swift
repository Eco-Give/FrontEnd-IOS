//
//  RankingView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 7/12/2023.
//

import SwiftUI

struct RankingView: View {
    @StateObject var viewModel = RankingViewModel()
    @State private var isBottomSheetPresented = false
    @State private var selectedActivity: UserStat?
    
    var body: some View {
        ZStack {
            VStack {
                Text("Ranking")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 80)
                    .foregroundColor(.green)
                    
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1), content: {
                        ForEach(viewModel.users, id: \.self) { user in
                            UserStatItemView(userStat: user)
                                .onTapGesture {
                                    selectedActivity = user
                                    isBottomSheetPresented.toggle()
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
    RankingView()
}
