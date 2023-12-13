import SwiftUI

struct TopBarView: View {
    
    
    var body: some View {
        HStack {
         
            
            Spacer()
            
            Text("Today")
            
            Spacer()
            
            Image(systemName: "bell.badge.fill")
        }
        .foregroundColor(.white)
        .font(.title)
        .padding()
    }
}
#Preview {
    TopBarView()
}
