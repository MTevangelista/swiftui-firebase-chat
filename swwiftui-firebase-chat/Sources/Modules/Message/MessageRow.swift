import SwiftUI

struct MessageRow: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .font(.system(size: 32))
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 44)
                        .stroke(Color(.label), lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.system(size: 16, weight: .bold))
                Text("Message sent to user")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.lightGray))
            }
            
            Spacer()
            
            Text("22d")
                .font(.system(size: 14, weight: .semibold))
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        Divider()
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MessageRow()
                .preferredColorScheme($0)
        }
    }
}
