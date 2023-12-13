//
//  ActivityItemView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 30/11/2023.
//

import SwiftUI

struct ActivityItemView: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(activity.Desc)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                HStack {
                    Image(systemName: "target")
                        .foregroundColor(.blue)
                    Text("Goal: \(activity.Goal)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                Image(systemName: "gift.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
                
                Text("Reward: \(activity.Reward.formatted())")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

struct ActivityItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityItemView(activity: Activity(Desc: "Achieve 50 Steps", Reward: 5, Goal: "5000"))
            .previewLayout(.sizeThatFits)
    }
}



