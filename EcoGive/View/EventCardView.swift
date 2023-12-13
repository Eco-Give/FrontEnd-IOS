// EventCardView.swift
// EcoGive
//
// Created by oumayma cherif on 29/11/2023.
//
import SwiftUI

struct EventCardView: View {
    let event: Event

    var body: some View {
        VStack(spacing: 12) {
            AsyncImageView(url: "http://172.18.15.242:3000/\(event.image ?? "")")
                .frame(width: 300, height: 200)
                .cornerRadius(16)
                .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 8) {
                Text(event.eventName ?? "")
                    .font(.title)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .padding(.horizontal, 8)

                Text(event.eventDescription ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .padding(.horizontal, 8)
            }
            .padding()

            Spacer()
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(8)
    }
}
