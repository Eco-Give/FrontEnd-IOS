import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearch: () -> Void

    var body: some View {
        TextField("Search by name", text: $searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
           // .background(Color.white.opacity(0.9))
            .cornerRadius(8)
            .padding(.horizontal)
            .shadow(radius: 3)
            .onSubmit(onSearch) // This triggers the search when the user presses return
    }
}
