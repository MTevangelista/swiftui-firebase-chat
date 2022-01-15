import SwiftUI

struct MainMessagesView: View {
    @State private var showActionSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar()
                
                ScrollView {
                    VStack {
                        ForEach(0..<10, id: \.self) { num in
                            MessageRow()
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            .overlay(newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
    
    var newMessageButton: some View {
        Button() {

        } label: {
            Text("+ New Message")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(32)
                .padding(.horizontal)
                .shadow(color: .black, radius: 3)
        }

    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MainMessagesView()
                .preferredColorScheme($0)
        }
    }
}
