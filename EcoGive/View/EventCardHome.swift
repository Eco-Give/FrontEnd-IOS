//
//  EventCardHome.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//
import SwiftUI

struct EventCardHome: View {
    let event: Event
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 10) {
            AsyncImageView(url: "http://192.168.100.6:3000/\(event.image ?? "")")
                .frame(width: 150, height: 150)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 1)
                )

            Text(event.eventName ?? "")
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .foregroundColor(colorScheme == .dark ? .white : .black) // Set text color based on color scheme
        }
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white) // Set background color based on color scheme
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
    }
}

