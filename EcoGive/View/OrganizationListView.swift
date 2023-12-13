//
//  OrganizationListView.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//
import SwiftUI

struct OrganizationListView: View {
    @ObservedObject var viewModel = OrganizationViewModel()

    @State private var selectedIndex: String = ""

    let gridItems = [
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.organizationsGrouped.keys.sorted(), id: \.self) { key in
                        Section(header: Text(String(key))) {
                            items(forSection: key)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.fetchOrganizations()
            }
            .navigationTitle("Organizations")
        }
    }

    private func items(forSection section: Character) -> some View {
        ForEach(viewModel.organizationsGrouped[section]!, id: \.self) { organization in
            NavigationLink(destination: OrganizationDetailView(organization: organization)) {
                OrganizationCardView(organization: organization)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 5)
            }
        }
    }
}
