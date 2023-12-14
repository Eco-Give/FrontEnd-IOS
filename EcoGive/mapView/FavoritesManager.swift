import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [Location] = []

    init() {
        loadFavorites()
    }

    func addFavorite(_ location: Location) {
        if !favorites.contains(where: { $0.id == location.id }) {
            favorites.append(location)
            saveFavorites()
        }
    }

    func removeFavorite(_ location: Location) {
        favorites.removeAll { $0.id == location.id }
        saveFavorites()
    }

    private func saveFavorites() {
        // Implement saving logic, e.g., using UserDefaults
    }

    private func loadFavorites() {
        // Implement loading logic, e.g., using UserDefaults
    }
}
