import SwiftUI
struct annotationView: View {

    @State private var name: String = ""
    @State private var category: String = ""
    @State private var instructions: String = ""
    @State private var address: String = ""
    @State private var description: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""

    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
           

            // Popup content
            VStack(spacing: 20) {
                TextField("Name", text: $name)
                   
                TextField("Category", text: $category)
                 
                TextField("Instructions", text: $instructions)
                   
                TextField("Address", text: $address)
                   
                TextField("Description", text: $description)
                    
                HStack(spacing: 10) {
                   
                    Text("latitude :36.434")
                    Text("longitude :10.224")
                   
                       
                }
                Button(action: {
                    // Handle submit action
                   
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.blue)
                        .cornerRadius(22)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding(20)
            .shadow(radius: 10)
        }
    }
}
