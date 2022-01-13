import Combine
import FirebaseAuth

struct AuthRemoteDataSource {
    static var shared: AuthRemoteDataSource = AuthRemoteDataSource()
    
    private init () {}
    
    func signIn(request: AuthRequest) -> Future<Bool, Error> {
        return Future { promise in
            FirebaseManager.shared.auth.signIn(withEmail: request.email,
                                               password: request.password) { result, error in
                if let error = error {
                    promise(.failure(error))
                }
                promise(.success(true))
            }
        }
    }
    
    func signUp(request: AuthRequest) -> Future<Bool, Error> {
        return Future { promise in
            FirebaseManager.shared.auth.createUser(withEmail: request.email,
                                                   password: request.password) { result, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                promise(.success(true))
            }
        }
    }
}
