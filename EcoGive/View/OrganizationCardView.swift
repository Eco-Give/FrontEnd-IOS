//
//  OrganizationCardView.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//
import SwiftUI

struct OrganizationCardView: View {
    let organization: Organization
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(organization.organizationName)
                .font(.headline)
                .lineLimit(1) // Limit the number of lines to 1
                .foregroundColor(colorScheme == .dark ? .white : .black) // Set text color based on color scheme

            Text("Phone: \(organization.organizationPhone)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(1) // Limit the number of lines to 1
        }
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white) // Set background color based on color scheme
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
