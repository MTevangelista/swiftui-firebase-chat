import SwiftUI
import SDWebImageSwiftUI

struct CustomNavBar: View {
    let photoURL: String
    let userEmail: String
    
    @State private var shouldShowLogOutOptions = false
    
    var body: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: photoURL))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                accountStatus
            }
            
            Spacer()
            
            settingsButton
        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            ActionSheet(title: Text("Settings"),
                        message: Text("What do you want to do?"),
                        buttons: [
                            .destructive(Text("Sign Out"), action: {
                                print("handle sign out")
                            }),
                            .cancel()
                        ])
        }
    }
    
    var accountStatus: some View {
        Group {
            Text(userEmail)
                .font(.system(size: 24, weight: .bold))
            
            HStack {
                Circle()
                    .foregroundColor(.green)
                    .frame(width: 14, height: 14)
                Text("online")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.lightGray))
            }
        }
    }
    
    var settingsButton: some View {
        Button {
            shouldShowLogOutOptions.toggle()
        } label: {
            Image(systemName: R.string.localizable.gearSystemImage())
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(.label))
        }
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(photoURL: R.string.localizable.exampleImageURL(),
                     userEmail: R.string.localizable.userEmailExample())
    }
}
