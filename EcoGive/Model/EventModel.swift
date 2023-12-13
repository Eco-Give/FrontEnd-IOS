//
//  EventModel.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//

import Foundation

struct Event: Identifiable, Hashable ,Decodable {
    let id: String
    let eventName: String?
    let eventDate: String?
    let eventLocation: String?
    let eventDescription: String?
    let image: String?
    let organization: String?
    let qrcode: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case eventName
        case eventDate
        case eventLocation
        case eventDescription
        case image
        case organization
        case qrcode
    }
    
    init (id: String, eventName: String, eventDate: String, eventLocation: String, eventDescription: String, image: String, organization: String, qrcode : String) {
        self.id = id
        self.eventName = eventName
        self.eventDate = eventDate
        self.eventLocation = eventLocation
        self.eventDescription = eventDescription
        self.image = image
        self.organization = organization
        self.qrcode = qrcode
    }
}
