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
                        .fill(Color(hex: 0xAFC8AD)) // Background color AFC8AD
                        .shadow(radius: 5)
                )
    }
}
struct RecDisplay: View {
    let title: String
    let description: String
    let type: String
    let userName: String
    @State private var isReclamationDetailVisible: Bool = false

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

            // Button to show detailed reclamation
            Button(action: {
                // Here you can handle the logic to show the detailed reclamation
                // and update the UI to display the admin response.
                isReclamationDetailVisible.toggle()
            }) {
                Text("View Response")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: 0x5F6F52))
                    .cornerRadius(5)
            }
            .sheet(isPresented: $isReclamationDetailVisible) {
                // DetailedReclamationView is a separate view for the detailed reclamation.
                DetailedReclamationView(adminResponse: "Your reclamation has been responded")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: 0xAFC8AD)) // Background color AFC8AD
                        .shadow(radius: 5)
                )
        .padding(.horizontal, 10)
    }
}

// Separate view for detailed reclamation





struct DetailedReclamationView: View {
    let adminResponse: String
    @State private var selectedStarCount: Int = 0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack {
            
            // Admin Avatar
            Image("omar") // Replace "adminAvatar" with the actual name of your admin avatar image
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 5)

            // Admin Response
            Text(adminResponse)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            // Star Rating
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= selectedStarCount ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            // Update the selected star count when tapped
                            selectedStarCount = index
                        }
                }
            }
            .padding()

            // Back Button
            Button(action: {
                // Dismiss the current view (navigate back to RecDisplay)
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                        .fontWeight(.semibold)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(hex: 0x5F6F52))
                .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color(hex: 0xAFC8AD))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}




struct DetailedReclamationView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedReclamationView(adminResponse: "Your reclamation has been responded. See you soon !!")
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
            
            ZStack{
             
                List(news, id: \.id) { test in
                    NavigationLink(destination: NewsDetail(newsData: test)) {
                        NewsDisp(
                            title: test.title,
                            description: test.description,
                            date: test.date
                        )
                    }
                }
            }
            .background(Color(hex: 0xAFC8AD))
            .onAppear {
                Task {
                    do {
                        let url = URL(string: "http://localhost:3001/api/news/")!
                        let (data, _) = try await URLSession.shared.data(from: url)

                        let response = try JSONDecoder().decode([String: [NewsData]].self, from: data)

                        if let message = response["message"] {
                            news = message
                        } else {
                            print("Error: 'message' key not found in the response")
                        }
                    } catch {
                        print("Error fetching news: \(error)")
                    }
                }
            }
            .navigationBarTitle("News")
        }
    }
}



struct NewsDetail: View {
    let newsData: NewsData

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Static Image
                Image("ghaza") // Replace "your_static_image_name" with the actual name of your image asset
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)

                // News Details
                VStack(alignment: .leading, spacing: 8) {
                    Text(newsData.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(newsData.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text("Date: \(newsData.date)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)

                // Share Button
                Button(action: {
                    // Create a URL to share, for example, the news article link
                    let newsURL = URL(string: "https://ecocive.tn/news/\(newsData.id)")!

                    // Create an instance of UIActivityViewController
                    let activityViewController = UIActivityViewController(activityItems: [newsURL], applicationActivities: nil)

                    // Exclude some activities from the share sheet if needed
                    activityViewController.excludedActivityTypes = [
                        .addToReadingList,
                        .airDrop,
                        .assignToContact
                    ]

                    // Present the UIActivityViewController
                    UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                }) {
                    Text("Share")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .navigationBarTitle("News Detail")
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
            ZStack{
              
                VStack{
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
                            .background(Color(hex: 0x5F6F52))
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
                }
            }
            .background(
                NavigationLink(
                    destination: HomeView(),
                    isActive: $navigateToHome,
                    label: { EmptyView() }
                )
            )
            .background(Color(hex: 0xAFC8AD))
            
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
        .background(
            Image("Back") // Replace "backgroundImage" with the actual name of your background image
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}
extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: 1
        )
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


