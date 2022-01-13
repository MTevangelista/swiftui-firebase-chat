import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    private let interactor: AuthInteractor
    
    @Published var uiState: AuthUIState = .none
    @Published var isLoginMode = false
    @Published var email = ""
    @Published var passwword = ""
    
    init(interactor: AuthInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func handleAction() {
        self.uiState = .loading
        isLoginMode ? signIn() : signUp()
    }
    
    private func signIn() {
        cancellable = interactor.signIn(request: AuthRequest(email: email, password: passwword))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.localizedDescription)
                case .finished: break
                }
            }, receiveValue: { successSignIn in
                self.uiState = .success
            })
    }
    
    private func signUp() {
        cancellable = interactor.signUp(request: AuthRequest(email: email, password: passwword))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.localizedDescription)
                case .finished: break
                }
            }, receiveValue: { successSignUp in
                self.uiState = .success
            })
    }
}
