//
//  Location.swift
//  mapView
////
//  Created by bilel dhif on 28/11/2023.
////

import Foundation

struct Location: Codable, Identifiable {
    var id: String
    var name: String
    var lat: Double
    var long: Double
    var adresse: String
    var categorie: String
    var instruction: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, lat, long, adresse, categorie, instruction, description
    }
}
