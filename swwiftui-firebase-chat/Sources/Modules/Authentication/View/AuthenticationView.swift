import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .autocapitalization(.none)
            .background(Color.white)
    }
}

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    Picker(R.string.localizable.authMode(), selection: $viewModel.isLoginMode) {
                        Text(R.string.localizable.signIn())
                            .tag(true)
                        Text(R.string.localizable.signUp())
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if !viewModel.isLoginMode {
                        personImageButton
                    }
                    
                    TextField(R.string.localizable.enterYourEmail(), text: $viewModel.email)
                        .textFieldStyle(CustomTextFieldStyle())
                        .keyboardType(.emailAddress)
                    
                    SecureField(R.string.localizable.enterYourPassword(), text: $viewModel.passwword)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    authButton
                }
                .padding()
            }
            .navigationBarTitle(R.string.localizable.authentication())
            .background(backgroundColor)
        }
    }
    
    var personImageButton: some View {
        Button {
            
        } label: {
            Image(systemName: R.string.localizable.personFillImage())
                .font(.system(size: 64))
                .padding()
        }
    }
    
    var authButton: some View {
        let text = viewModel.isLoginMode
            ? "Log In"
            : "Create Account"
        
        return Button(text, action: viewModel.handleAction)
            .padding(10)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
    }
    
    var backgroundColor: some View {
        Color(.init(white: 0, alpha: 0.05))
            .ignoresSafeArea()
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
