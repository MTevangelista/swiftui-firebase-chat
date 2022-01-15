import SwiftUI

struct CustomNavBar: View {
    @State var shouldShowLogOutOptions = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
            
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
            Text("USERNAME")
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
            Image(systemName: "gear")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(.label))
        }
    }
    
    var actionSheet: some View {
        Group {
            
        }
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar()
    }
}
