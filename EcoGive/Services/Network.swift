//
//  Network.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation
class EventService {
    func fetchEvents(completion: @escaping ([Event]?) -> Void) {
        guard let url = URL(string: "https://localhost:3000/events") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
        do {
                let decodedEvents = try JSONDecoder().decode([Event].self, from: data)
                completion(decodedEvents)
            } catch {
                print("Erreur de décodage : \(error)")
                completion(nil)
            }
        }.resume()
    }
}
