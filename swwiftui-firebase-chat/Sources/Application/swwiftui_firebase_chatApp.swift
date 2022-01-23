import SwiftUI

@main
struct swwiftui_firebase_chatApp: App {
    var body: some Scene {
        WindowGroup {
            //AuthView(viewModel: AuthViewModel(interactor: AuthInteractor()))
            MessagesView(viewModel: MessagesViewModel(interactor: MessageInteractor()))
        }
    }
}
