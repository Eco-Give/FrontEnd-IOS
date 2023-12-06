import SwiftUI

struct NewsDisp: View {
    let title: String
    let description: String
    let date: String
    

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "newspaper") // You can replace this with the actual image from your data
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 150) // Adjust the size as needed
                            .cornerRadius(10) // Apply corner radius to the image

            Text("Title:")
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Text("description:")
            Text(description)
                .foregroundColor(.secondary)
            HStack {
                Text("date:")
                    .foregroundColor(.secondary)
                Text(date)
            }
           
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
        )
    }
}
struct RecDisplay: View {
    let title: String
    let description: String
    let type: String
    let userName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
               Text(title)
                   .font(.title)
                   .fontWeight(.bold)
               Text(description)
                   .foregroundColor(.secondary)
               HStack {
                   Text("Type:")
                       .foregroundColor(.secondary)
                   Text(type)
               }
               HStack {
                   Text("User:")
                       .foregroundColor(.secondary)
                   Text(userName)
               }
           }
           .padding()
           .frame(maxWidth: .infinity) // Ensure the content takes the full width
           .background(
               RoundedRectangle(cornerRadius: 10)
                   .fill(Color.white)
                   .shadow(radius: 5)
           )
           .padding(.horizontal, 10) // Optional: Add padding to the sides of the VStack
       }
    }

struct HomeView: View {
    @State private var reclamations: [ReclamationData] = []

    var body: some View {
        NavigationView {
            List(reclamations, id: \.id) { reclamation in
                RecDisplay(
                    title: reclamation.title,
                    description: reclamation.description,
                    type: reclamation.type,
                    userName: "Test"
                )
            }
            .onAppear {
                Task {
                    do {
                        let url = URL(string: "http://localhost:3001/api/reclamations/")!
                        let (data, _) = try await URLSession.shared.data(from: url)

                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print("JSON Response: \(json)")
                        } catch {
                            print("Error converting data to JSON: \(error)")
                        }

                        let response = try JSONDecoder().decode([String: [ReclamationData]].self, from: data)

                        if let message = response["message"] {
                            reclamations = message
                        } else {
                            print("Error: 'message' key not found in the response")
                        }
                    } catch {
                        print("Error fetching reclamations: \(error)")
                    }
                }
            }
            .navigationBarTitle("Reclamations")
        }
    }
}
struct NewsDisplay: View {
    @State private var news: [NewsData] = []

    var body: some View {
        NavigationView {
            List(news, id: \.id) { test in
                NewsDisp(
                    title: test.title,
                    description: test.description,
                    date: test.date
                    
                )
            }
            .onAppear {
                Task {
                    do {
                        let url = URL(string: "http://localhost:3001/api/news/")!
                        let (data, _) = try await URLSession.shared.data(from: url)

                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print("JSON Response: \(json)")
                        } catch {
                            print("Error converting data to JSON: \(error)")
                        }

                        let response = try JSONDecoder().decode([String: [NewsData]].self, from: data)

                        if let message = response["message"] {
                            news = message
                        } else {
                            print("Error: 'message' key not found in the response")
                        }
                    } catch {
                        print("Error fetching reclamations: \(error)")
                    }
                }
            }
            .navigationBarTitle("News")
        }
    }
}


struct AddReclamationView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var type = ""
    @State private var userName = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reclamation Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Type", text: $type)
                    TextField("User", text: $userName)
                }

                Section {
                    Button("Save Reclamation", action: {
                        Task {
                            await addReclamation()
                        }
                    })
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            .navigationBarTitle("Add Reclamation")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Reclamation added successfully!"),
                    dismissButton: .default(Text("OK"), action: {
                        navigateToHome = true
                    })
                )
            }
            .background(
                NavigationLink(
                    destination: HomeView(),
                    isActive: $navigateToHome,
                    label: { EmptyView() }
                )
            )
        }
    }
    
    private func addReclamation() async {
            do {
                let url = URL(string: "http://localhost:3001/api/reclamations/store")!
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let requestData = ReclamationData(id:randomString(length: 8),title: title, description: description, type: type)
                let encodedData = try JSONEncoder().encode(requestData)
                urlRequest.httpBody = encodedData

                let (data, response) = try await URLSession.shared.data(for: urlRequest)

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Reclamation added successfully!")
                } else {
                    let errorData = try JSONDecoder().decode(ErrorData.self, from: data)
                    print("Error: \(errorData.message)")
                    showAlert = true
                    alertMessage = "Failed to add reclamation. \(errorData.message)"
                }
            } catch {
                print("Error: \(error)")
                showAlert = true
                alertMessage = "An error occurred. Please try again."
            }
        }
    func randomString(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<length).map { _ in letters.randomElement()! })
        }
    }

struct ReclamationData: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title, description, type
    }
}
struct NewsData: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, description, date
    }
}

    struct ErrorData: Decodable {
        let message: String
    }




struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            AddReclamationView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Reclamation")
                }
            NewsDisplay()
                .tabItem {
                    Image(systemName: "square.fill")
                    Text("News")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

