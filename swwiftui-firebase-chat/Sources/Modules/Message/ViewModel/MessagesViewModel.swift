import SwiftUI
import Combine

class MessagesViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    private let interactor: MessageInteractor
    
    @Published var uiState: UIState = .none
    @Published var chatUser: ChatUser?
    
    init(interactor: MessageInteractor) {
        self.interactor = interactor
        fetchCurrentUser()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    private func fetchCurrentUser() {
        uiState = .loading
        cancellable = interactor.fetchCurrentUser()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished: break
                }
            }, receiveValue: { currentUser in
                let uid = currentUser["uid"] as? String ?? ""
                let email = currentUser["email"] as? String ?? ""
                let photoURL = currentUser["photoURL"] as? String ?? ""
                
                self.chatUser = ChatUser(uid: uid,
                                         email: self.replacedEmail(value: email),
                                         photoURL: photoURL)
                self.uiState = .success
            })
    }
    
    private func replacedEmail(value: String) -> String {
        return value.replacingOccurrences(of: MessageConstants.replacingEmailOccurrences.of,
                                                  with: MessageConstants.replacingEmailOccurrences.with)
    }
}
