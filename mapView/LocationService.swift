//
//  LocationService.swift
//  mapView
//
//  Created by MacBook Pro on 1/12/2023.
//

import Foundation

class LocationService {
    static func fetchLocations(completion: @escaping ([Location]) -> Void) {
        guard let url = URL(string: "http://172.20.10.2:9090/getall") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }

            if let locations = try? JSONDecoder().decode([Location].self, from: data) {
                DispatchQueue.main.async {
                    completion(locations)
                }
            }
        }.resume()
    }
}
