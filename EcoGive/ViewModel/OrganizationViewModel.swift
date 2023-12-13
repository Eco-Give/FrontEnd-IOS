//
//  OrganizationViewModel.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//

import Combine
import Foundation
import SwiftUI
class OrganizationViewModel: ObservableObject {
    @Published var organizations: [Organization] = []
    @Published var organizationsGrouped: [Character: [Organization]] = [:]
    @Published var selectedOrganization: Organization?

    func fetchOrganizations() {
        OrganizationService.shared.fetchOrganizations { result in
            switch result {
            case .success(let organizations):
                DispatchQueue.main.async {
                    self.organizations = organizations
                    self.updateOrganizationsGrouped()
                }
            case .failure(let error):
                print("Error fetching organizations:", error)
            }
        }
    }

    private func updateOrganizationsGrouped() {
        organizationsGrouped = Dictionary(grouping: organizations) { organization in
            let firstCharacter = organization.organizationName.first
            return firstCharacter != nil ? firstCharacter! : "?"
        }
        .mapValues { $0.sorted(by: { $0.organizationName < $1.organizationName }) }

        // Notify subscribers that the data has changed
        objectWillChange.send()
    }

    func selectOrganization(_ organization: Organization) {
        selectedOrganization = organization
    }
}
