import Foundation

class LocationFetcher: ObservableObject {
    @Published var locations: [Location] = []

    func fetchLocations() {
        guard let url = URL(string: "http://172.20.10.2:8088/getall") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                if let decodedResponse = try? JSONDecoder().decode([Location].self, from: data) {
                    DispatchQueue.main.async {
                        self.locations = decodedResponse
                    }
                } else {
                    print("JSON Decoding failed")
                }
            } else {
                print("Network request failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        task.resume()
    }
    // New method to make a call
       func makeCall() {
           guard let url = URL(string: "172.20.10.2:8088//call") else {
               print("Invalid URL")
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")

           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error in making call: \(error)")
                   return
               }
               if let data = data {
                   if let responseString = String(data: data, encoding: .utf8) {
                       print("Response from call: \(responseString)")
                   }
               }
           }

           task.resume()
       }
}
