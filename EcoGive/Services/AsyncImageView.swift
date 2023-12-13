//
//  AsyncImageView.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var data = Data()
    private var cancellables: Set<AnyCancellable> = []

    init(url: String) {
        guard let imageURL = URL(string: url) else {
            print("Invalid URL: \(url)")
            return
        }

        URLSession.shared.dataTaskPublisher(for: imageURL)
            .map(\.data)
            .replaceError(with: Data())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error loading image:", error)
                }
            } receiveValue: { [weak self] data in
                self?.data = data
            }
            .store(in: &cancellables)
    }
}

struct AsyncImageView: View {
    @StateObject private var imageLoader: ImageLoader

    init(url: String) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        if let uiImage = UIImage(data: imageLoader.data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill().background(Color.clear)
        } else {
            // Placeholder image or loading indicator
            Color.gray
                .onAppear {
                    print("Image loading failed. Check URL or internet connection.")
                }
        }
    }
}
