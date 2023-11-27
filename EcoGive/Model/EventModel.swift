//
//  Event.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation
import Foundation

struct Event: Codable, Identifiable {
    let id: String
    let eventName: String
    let eventDate: String
    let eventLocation: String
    let eventDescription: String
    let organization: String
    let image: String
    let qrcode: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case eventName, eventDate, eventLocation, eventDescription, organization, image, qrcode
    }
}

