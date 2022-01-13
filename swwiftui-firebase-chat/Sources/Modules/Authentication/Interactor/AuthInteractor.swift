import Combine

struct AuthInteractor {
    private let remote: AuthRemoteDataSource = .shared
    
    func signIn(request: AuthRequest) -> Future<Bool, Error> {
        return remote.signIn(request: request)
    }
    
    func signUp(request: AuthRequest) -> Future<Bool, Error> {
        return remote.signUp(request: request)
    }
}
