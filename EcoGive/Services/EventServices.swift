//
//  EventServices.swift
//  EcoGive
//
//  Created by oumayma cherif on 27/11/2023.
//

import Foundation
import Alamofire



struct EventService {
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
            AF.request("\(Network.fetchEventsUrl)", method: .get, encoding: JSONEncoding.default)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decodedData = try JSONDecoder().decode([Event].self, from: data)
                            completion(.success(decodedData))
                        } catch {
                            print("Error decoding JSON: \(error)")
                            completion(.failure(error))
                        }

                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        completion(.failure(error))
                    }
                }
        }
    }
