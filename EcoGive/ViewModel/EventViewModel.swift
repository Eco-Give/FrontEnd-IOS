//
//  EventViewModel.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//
// EventViewModel.swift

import Foundation
import Combine
import Alamofire

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var selectedEvent: Event?
    
    func fetchEvents() {
        let url = URL(string: "http://192.168.100.6:3000/events")!
        
        AF.request(url)
            .responseDecodable(of: [Event].self) { response in
                switch response.result {
                case .success(let events):
                    DispatchQueue.main.async {
                        self.events = events
                    }
                case .failure(let error):
                    print("Error fetching events:", error)
                }
            }
    }
    
    func fetchEventDetails(eventID: String) {
        let url = URL(string: "http://192.168.100.6:3000/events/\(eventID)")!
        
        AF.request(url)
            .responseDecodable(of: Event.self) { response in
                switch response.result {
                case .success(let event):
                    // Update the selected event in the ViewModel
                    DispatchQueue.main.async {
                        self.selectedEvent = event
                    }
                case .failure(let error):
                    print("Error fetching event details:", error)
                }
            }
    }
}
