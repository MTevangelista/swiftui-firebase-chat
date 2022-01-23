import SwiftUI

struct MessagesView: View {
    @State private var showActionSheet = false
    
    @ObservedObject var viewModel: MessagesViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                //Text("User: \(viewModel.chatUser?.uid ?? "")")
                
                CustomNavBar(photoURL: viewModel.chatUser?.photoURL ?? R.string.localizable.exampleImageURL(),
                             userEmail: viewModel.chatUser?.email ?? R.string.localizable.userEmailExample())
                
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

struct MessagesViewView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MessagesView(viewModel: MessagesViewModel(interactor: MessageInteractor()))
                .preferredColorScheme($0)
        }
    }
}
