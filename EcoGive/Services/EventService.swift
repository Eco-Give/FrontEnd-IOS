//
//  EventService.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//


import Combine
import Foundation
import Alamofire

class EventService {
    static let shared = EventService()

    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        let url = URL(string: "http://192.168.100.6:3000/events")!

        AF.request(url)
            .responseDecodable(of: [Event].self) { response in
                switch response.result {
                case .success(let events):
                    completion(.success(events))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
