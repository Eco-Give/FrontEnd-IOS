//
//  ActivityBottomSheetView.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 7/12/2023.
//

import SwiftUI

struct ActivityBottomSheetView: View {
    let activity: Activity

    var body: some View {
        VStack {
            Text(activity.Desc)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)

            Divider()
                .padding(.bottom, 16)

            HStack {
                Image(systemName: "target")
                    .foregroundColor(.blue)
                Text("Goal: \(activity.Goal)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 16)

            HStack {
                Image(systemName: "gift.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.green)
                Text("Reward: \(activity.Reward.formatted())")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
            .padding(.bottom, 16)

            Spacer()

            Button("Claim Reward") {
                // Add logic to claim the reward
            }
            .buttonStyle(ClaimButtonStyle())
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

struct ClaimButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.green.opacity(0.8) : Color.green)
            .cornerRadius(10)
    }
}

struct ActivityBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityBottomSheetView(activity: Activity(Desc: "Achieve 50 Steps", Reward: 5, Goal: "5000"))
    }
}

