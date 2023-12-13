//
//  RankingViewModel.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 7/12/2023.
//

import SwiftUI

class RankingViewModel: ObservableObject {
    @Published var users: [UserStat] = []

    func fetch() {
        guard let url = URL(string: "http://192.168.1.28:9090/userstat/getall") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            // Convert to JSON
            do {
                let decodedUserStats = try JSONDecoder().decode([UserStat].self, from: data)

                // Update the @Published property on the main thread
                DispatchQueue.main.async {
                    self.users = decodedUserStats
                    print(decodedUserStats)
                }
            } catch {
                print(error)
            }
        }

        task.resume()
    }
}


