//
//  OrganizationModel.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//

import Foundation

struct Organization: Identifiable, Hashable, Decodable  {
    let id: String
    let organizationName: String
    let organizationDescription: String
    let organizationAddress: String
    let organizationEmail: String
    let organizationPhone: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case organizationName
        case organizationDescription
        case organizationAddress
        case organizationEmail
        case organizationPhone
    }

    init(id: String, organizationName: String, organizationDescription: String, organizationAddress: String, organizationEmail: String, organizationPhone: String) {
        self.id = id
        self.organizationName = organizationName
        self.organizationDescription = organizationDescription
        self.organizationAddress = organizationAddress
        self.organizationEmail = organizationEmail
        self.organizationPhone = organizationPhone
    }
}
