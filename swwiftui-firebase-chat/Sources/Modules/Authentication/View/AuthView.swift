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
    
    @State var shouldPresentImagePicker = false
    
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
            shouldPresentImagePicker.toggle()
        } label: {
            personImage
        }
        .sheet(isPresented: $shouldPresentImagePicker) {
            ImagePicker(selectedImage: $viewModel.image, sourceType: .camera)
        }
    }
    
    var personImage: some View {
        Group {
            if viewModel.image.size.width > 0 {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
            } else {
                Image(systemName: R.string.localizable.personFillImage())
                    .font(.system(size: 64))
                    .padding()
                    .foregroundColor(.black)
            }
        }
        .overlay(Circle().stroke(Color.black, lineWidth: 3))
    }
    
    var someFormFieldIsEmpty: Bool {
        viewModel.email.isEmpty || viewModel.passwword.isEmpty
    }
    
    var handleLoadingButtonText: String  {
        viewModel.isLoginMode ? "Log In" : "Create Account"
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
