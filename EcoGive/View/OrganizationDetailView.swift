//
//  OrganizationDetailView.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//


import SwiftUI
struct OrganizationDetailView: View {
    let organization: Organization

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                  //  Text(organization.organizationName)
                    //    .font(.largeTitle)
                     //   .bold()
                     //   .foregroundColor(.primary)
                     //   .padding(.horizontal, 30)

                    Text("Description:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 30)
                    Text(organization.organizationDescription)
                        .font(.body)
                        .padding(.horizontal, 30)

                    Text("Address:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 30)
                    Text(organization.organizationAddress)
                        .font(.body)
                        .padding(.horizontal, 30)

                    Text("Email:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 30)
                    Text(organization.organizationEmail)
                        .font(.body)
                        .padding(.horizontal, 30)

                    Text("Phone:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 30)
                    Text(organization.organizationPhone)
                        .font(.body)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 20)
            }
        }
        .navigationTitle(organization.organizationName)
    }
}
