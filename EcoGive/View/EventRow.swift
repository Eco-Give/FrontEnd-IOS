//
//  EventRow.swift
//  EcoGive
//
//  Created by oumayma cherif on 26/11/2023.
//

import Foundation
import SwiftUI

struct EventRow: View {
    var event: Event

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.eventName)
                .font(.headline)
            Text("Date: \(event.eventDate)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(8)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEvent = Event(
            _id: "123",
            eventName: "Sample Event",
            eventDate: "2023-12-01",
            eventLocation: "Sample Location",
            eventDescription: "Description of the event",
            organization: "Sample Organization",
            image: "sampleImageURL",
            qrcode: "sampleQRCodeURL"
        )

        EventRow(event: sampleEvent)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
