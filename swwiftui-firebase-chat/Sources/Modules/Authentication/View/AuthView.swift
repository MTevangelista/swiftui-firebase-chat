import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .autocapitalization(.none)
            .background(Color.white)
            .disableAutocorrection(true)
    }
}

struct AuthView: View {
    @StateObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            if case AuthUIState.error(let errorMessage) = viewModel.uiState {
                AlertView(value: errorMessage)
            }
            
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
                        
                        LoadingButton(action: viewModel.handleAction,
                                      text: handleLoadingButtonText,
                                      shouldPresentProgress: viewModel.uiState == AuthUIState.loading,
                                      isDisabled: someFormFieldIsEmpty)
                    }
                    .padding()
                }
                .navigationBarTitle(R.string.localizable.authentication())
                .background(backgroundColor)
            }
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
    
    var handleLoadingButtonText: String  {
        viewModel.isLoginMode ? "Log In" : "Create Account"
    }
    
    var someFormFieldIsEmpty: Bool {
        viewModel.email.isEmpty || viewModel.passwword.isEmpty
    }

    var backgroundColor: some View {
        Color(.init(white: 0, alpha: 0.05))
            .ignoresSafeArea()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(viewModel: AuthViewModel(interactor: AuthInteractor()))
    }
}
