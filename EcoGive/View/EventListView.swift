//
//  EventListView.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//

// EventListView.swift
import SwiftUI

struct EventListView: View {
    // Using @ObservedObject to observe changes in the EventViewModel
    @ObservedObject var viewModel = EventViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.events) { event in
                // Each event in the list is a NavigationLink leading to EventDetailView
                NavigationLink(destination: EventDetailView(eventViewModel: viewModel, event: event)) {
                    // EventCardView is used to display each event in the list
                    EventCardView(event: event)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color(.secondarySystemBackground))
                                .shadow(radius: 5)
                        )
                }
            }
            .navigationTitle("Events") // Setting the navigation title
        }
        .onAppear {
            // Fetch events when the view appears
            viewModel.fetchEvents()
        }
    }
}
