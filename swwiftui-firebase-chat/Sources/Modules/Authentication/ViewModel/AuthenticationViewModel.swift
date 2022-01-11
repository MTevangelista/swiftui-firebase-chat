import SwiftUI

final class AuthenticationViewModel: ObservableObject {
    var email = ""
    var passwword = ""
    
    @Published var isLoginMode = false
    
    func handleAction() {
        isLoginMode
            ? print("Should log into Firebase with existing credentials")
            : print("Register a new account inside of Firebase Auth and then store image in Storage somehow...")
    }
}
