//
//  Event.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation
import SwiftUI
import SwiftUI

struct EventView: View {
    @ObservedObject var eventViewModel = EventViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if eventViewModel.isLoading {
                    ProgressView("Loading Events...")
                        .padding()
                } else if !eventViewModel.events.isEmpty {
                    List(eventViewModel.events) { event in
                        EventRow(event: event)
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Text("No events available.")
                        .padding()
                }
            }
            .navigationTitle("Events")
            .onAppear {
                eventViewModel.fetchEvents()
            }
        }
    }
}

struct EventRow: View {
    let event: Events

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.eventName)
                .font(.headline)
            Text("Date: \(event.eventDate)")
                .font(.subheadline)
            Text("Location: \(event.eventLocation)")
                .font(.subheadline)
            // Add more details if needed
        }
        .padding()
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
