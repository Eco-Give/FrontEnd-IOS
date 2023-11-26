//
//  Network.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
struct Network
{ static let Base_URL = "http://localhost:3000"
    
    
    
    
 static let fetchEventUrl = Base_URL + "/events"
    
>>>>>>> parent of 5d967a2 (0.1)
}
=======
>>>>>>> parent of c207951 (0.2)
