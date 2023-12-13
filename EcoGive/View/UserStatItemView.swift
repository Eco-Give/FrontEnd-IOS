import SwiftUI

struct UserStatItemView: View {
    let userStat: UserStat
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "rosette")
                        .foregroundColor(.blue)
                    Text("Rank \(userStat.Level)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                
                HStack {
                    Image(systemName: "figure.walk")
                        .foregroundColor(.green)
                    Text("Steps: \(userStat.StepCount)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
            }
            .padding(10)
            
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

struct UserStatItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatItemView(userStat: UserStat(Level: "17", StepCount: "5000", UserId: "1"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
