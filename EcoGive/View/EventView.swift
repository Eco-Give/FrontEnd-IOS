//
//  EventView.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation
import SwiftUI
struct EventListView: View {
@ObservedObject var viewModel = EventViewModel()

var body: some View {
    NavigationView {
        if viewModel.events.isEmpty {
            Text("Aucun événement disponible.")
        } else {
            List(viewModel.events) { event in
                EventRow(event: event)
            }
            .onAppear {
                viewModel.fetchEvents()
            }
            .navigationTitle("Événements")
        }
    }
}
}
