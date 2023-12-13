import SwiftUI

struct OrganizationRow: View {
    let organization: Organization
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(organization.organizationName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(colorScheme == .dark ? .white : .black)

                Text("Phone: \(organization.organizationPhone)")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .gray : .black)
                    .lineLimit(1)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)

            Spacer()
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
    }
}
