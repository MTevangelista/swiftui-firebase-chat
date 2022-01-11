import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    
    //@State private var isLoginMode = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    Picker(selection: $viewModel.isLoginMode, label: Text(R.string.localizable.authMode())) {
                        Text(R.string.localizable.signIn())
                            .tag(true)
                        Text(R.string.localizable.signUp())
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if !viewModel.isLoginMode {
                        Button {
                            
                        } label: {
                            Image(systemName: R.string.localizable.personFillImage())
                                .font(.system(size: 64))
                                .padding()
                        }
                    }
                    
                    TextField("Email", text: $viewModel.email)
                        .padding(12)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .background(Color.white)
                    
                    SecureField("Passord", text: $viewModel.passwword)
                        .padding(12)
                        .autocapitalization(.none)
                        .background(Color.white)
                    
                    Button {
                        viewModel.handleAction()
                    } label: {
                        Text(viewModel.isLoginMode ? "Log In" : "Create Account")
                            .padding(10)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Authentication")
            .background(
                Color(.init(white: 0, alpha: 0.05))
                    .ignoresSafeArea()
            )
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
