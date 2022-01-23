import SwiftUI

class MainViewModel: ObservableObject {}

// MARK: - Routers
extension MainViewModel {
    func messagesView() -> some View {
        return MainViewRouter.makeMessagesView()
    }
}
