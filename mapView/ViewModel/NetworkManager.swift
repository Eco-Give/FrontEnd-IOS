//
//  NetworkManager.swift
//  mapView
//
//  Created by bilel dhif on 28/11/2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func getlocation(completion: @escaping (Result<[Location], Error>) -> Void) {
        let urlString = "http://172.18.14.229:9090/getall"
        guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
        
        request.cachePolicy = .reloadRevalidatingCacheData
        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
           
           // print(String(data: data, encoding: .utf8) ?? "BN")
            do {
                let location = try JSONDecoder().decode([Location].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(location))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
