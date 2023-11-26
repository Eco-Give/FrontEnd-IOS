//
//  EventViewModel.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation
import SwiftUI
class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = false
    private var eventService = EventService()
    
    func fetchEvents() {
        isLoading = true
        eventService.fetchEvents { [weak self] events in
            DispatchQueue.main.async {
                self?.events = events ?? []
                self?.isLoading = false
            }
        }
    }
}
