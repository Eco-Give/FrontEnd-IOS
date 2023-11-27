//
//  test.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation
import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = true
    @Published var message: String = ""

    func fetchEvents() {
        EventService().fetchEvents { result in
            switch result {
            case .success(let fetchedEvents):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.events = fetchedEvents
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error fetching events: \(error.localizedDescription)")
                    self.message = "Error fetching events: \(error.localizedDescription)"
                }
            }
        }
    }
}
