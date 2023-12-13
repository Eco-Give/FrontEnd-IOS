//
//  OrganizationService.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//

import Combine
import Foundation
import Alamofire

class OrganizationService {
    static let shared = OrganizationService()

    func fetchOrganizations(completion: @escaping (Result<[Organization], AFError>) -> Void) {
        let url = "http://192.168.100.6:3000/organizations"

        AF.request(url)
            .responseDecodable(of: [Organization].self) { response in
                switch response.result {
                case .success(let organizations):
                    print("Successfully fetched organizations:", organizations)
                    completion(.success(organizations))
                case .failure(let error):
                    print("Error fetching organizations:", error)
                    completion(.failure(error))
                }
            }
    }
}
