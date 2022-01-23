import SwiftUI

struct MainViewRouter {
    static func makeMessagesView() -> some View {
        return MessagesView(viewModel: MessagesViewModel(interactor: MessageInteractor()))
    }
}
