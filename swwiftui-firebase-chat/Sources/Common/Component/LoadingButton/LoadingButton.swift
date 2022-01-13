import SwiftUI

struct LoadingButton: View {
    var action: () -> Void
    var text: String
    var background: Color = .blue
    var foregroundColor: Color = .white
    var shouldPresentProgress: Bool = false
    var isDisabled: Bool = false
    
    var body: some View {
        ZStack {
            Button {
                action()
            } label: {
                Text(shouldPresentProgress ? "" : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14).padding(.horizontal, 16)
                    .background(background)
                    .foregroundColor(foregroundColor)
                    .font(.system(size: 17).bold())
                    .opacity(isDisabled ? 0.6 : 1)
            }
            .disabled(isDisabled || shouldPresentProgress)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(shouldPresentProgress ? 1 : 0)
        }
    }
}

struct LoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoadingButton(action: {
                print("Hello, Word!")
            },
            text: "Entrar",
            shouldPresentProgress: false,
            isDisabled: false)
        }
        .padding()
    }
}
