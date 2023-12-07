import Foundation

class LocationFetcher: ObservableObject {
    @Published var locations: [Location] = []

    func fetchLocations() {
<<<<<<< Updated upstream
        guard let url = URL(string: "http://172.18.20.178:9090/getall") else {
=======
        guard let url = URL(string: "http://172.18.8.139:9090/getall") else {
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
           guard let url = URL(string: "http://172.18.20.178:9090/call") else {
=======
           guard let url = URL(string: "http://172.18.8.139:9090/call") else {
>>>>>>> Stashed changes
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
