

import SwiftUI



struct SideMenuViewContents: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Color.backgroundGradient,
                center: .bottomTrailing,
                startAngle: .degrees(170),
                endAngle: .degrees(270))
                .blur(radius: 70, opaque: true)
            VStack(alignment: .leading, spacing: 0) {
                
                VStack {
                    HStack {
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30) // Adjust the size as needed
                            .foregroundColor(.green)

                        Text("Home")
                            .font(.headline) // Adjust the font size as needed
                    }
                    .padding(.top, 100)

                    HStack {
                        Image(systemName: "gift")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30) // Adjust the size as needed
                            .foregroundColor(.green)

                        Text("Rewards")
                            .font(.headline) // Adjust the font size as needed
                    }
                    .padding(.top, 30)

                    HStack {
                        Image(systemName: "medal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30) // Adjust the size as needed
                            .foregroundColor(.green)

                        Text("Ranking")
                            .font(.headline) // Adjust the font size as needed
                    }
                    .padding(.top, 30)

                    Spacer()
                }
                .padding()
                .frame( maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            
        }
    }
    
    func SideMenuTopView() -> some View {
        VStack {
            HStack {
              
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 40)
        .padding(.top, 40)
        .padding(.bottom, 30)
    }
}
#Preview {
    SideMenuViewContents(presentSideMenu: .constant(true))
}
