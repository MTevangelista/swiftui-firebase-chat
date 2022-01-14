import Combine
import SwiftUI

struct AuthInteractor {
    private let remote: AuthRemoteDataSource = .shared
    
    func signIn(request: AuthRequest) -> Future<Bool, Error> {
        return remote.signIn(request: request)
    }
    
    func signUp(request: AuthRequest) -> Future<Bool, Error> {
        return remote.signUp(request: request)
    }
    
    func persistImageToStorage(image: UIImage) -> Future<URL, AppError> {
        return remote.persistImageToStorage(image: image)
    }
    
    func storeUserInformation(request: UserRequest) -> Future<Bool, Error> {
        return remote.storeUserInformation(request: request)
    }
}
