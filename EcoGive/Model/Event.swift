//
//  Event.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation

struct Event: Identifiable, Hashable, Decodable {
    var id: String { _id }

    var _id: String
    var eventName: String
    var eventDate: String
    var eventLocation: String
    var eventDescription: String
    var organization: String
    var image: String
    var qrcode: String

    // Optional: Add default values
    // var eventLocation: String = "Default Location"

    // Custom Coding Keys if needed
    // private enum CodingKeys: String, CodingKey {
    //     case _id
    //     case eventName
    //     case eventDate
    //     case eventLocation
    //     case eventDescription
    //     case organization
    //     case image
    //     case qrcode
    // }

    // Optional: Convenience initializer
    // init(eventName: String, eventDate: String, /* other properties */) {
    //     self._id = UUID().uuidString
    //     self.eventName = eventName
    //     self.eventDate = eventDate
    //     // Initialize other properties
    // }
}
