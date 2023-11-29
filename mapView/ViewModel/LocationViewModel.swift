//
//  LocationViewModel.swift
//  mapView
//
//  Created by bilel dhif on 28/11/2023.
//

import Foundation
class LocationViewModel: ObservableObject {
    @Published var location = [Location]()

    func getlocation() {
        NetworkManager.shared.getlocation { [weak self] result in
            switch result {
            case .success(let location):
                DispatchQueue.main.async {
                    self?.location = location
                }
            case .failure(let error):
                // Handle error, update UI accordingly
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

