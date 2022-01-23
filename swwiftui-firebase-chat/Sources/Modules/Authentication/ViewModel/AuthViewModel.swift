import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    private let interactor: AuthInteractor
    
    @Published var uiState: UIState = .none
    @Published var isLoginMode = false
    @Published var image = UIImage()
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
                self.persistImageToStorage()
            })
    }
    
    private func persistImageToStorage() {
        cancellable = interactor.persistImageToStorage(image: image)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.message)
                case .finished: break
                }
            }, receiveValue: { savedImage in
                self.uiState = .success
                guard let uid = FirebaseManager.getUID() else { return }
                let user = UserRequest(uid: uid,
                                       photoURL: savedImage,
                                       email: self.email,
                                       password: self.passwword)
                self.storeUserInformation(user)
            })
    }
    
    private func storeUserInformation(_ user: UserRequest) {
        cancellable = interactor.storeUserInformation(request: user)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.localizedDescription)
                case .finished: break
                }
            }, receiveValue: { storedUser in
                self.uiState = .success
            })
    }
}
