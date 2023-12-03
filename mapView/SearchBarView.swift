//
//  SearchBar.swift
//  mapView
//
//  Created by MacBook Pro on 3/12/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: (String) -> Void

    var body: some View {
        TextField("Search", text: $text, onCommit: {
            onSearch(text)
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 3)
    }
}
