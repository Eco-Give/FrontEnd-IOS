//
//  ActivityListViewModel.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 7/12/2023.
//

import SwiftUI

class ActivityListViewModel: ObservableObject {
    @Published var activities: [Activity] = []

    func fetch() {
        guard let url = URL(string: "http://172.20.10.2:9090/activity/getall") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            // Convert to JSON
            do {
                let decodedActivities = try JSONDecoder().decode([Activity].self, from: data)

                // Update the @Published property on the main thread
                DispatchQueue.main.async {
                    self.activities = decodedActivities
                    print(decodedActivities)
                }
            } catch {
                print(error)
            }
        }

        task.resume()
    }
}
