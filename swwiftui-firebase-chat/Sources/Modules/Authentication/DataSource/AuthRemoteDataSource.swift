import Combine
import FirebaseAuth
import FirebaseStorage

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
    
    func persistImageToStorage(image: UIImage) -> Future<URL, AppError> {
        return Future { promise in
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
            let newMetadata = StorageMetadata()
            let ref = FirebaseManager.shared.storage.reference(withPath: FirebaseManager.getUID())
            
            newMetadata.contentType = "image/jpeg"
            ref.putData(imageData, metadata: newMetadata) { metadata, error in
                if let _ = error {
                    promise(.failure(AppError(message: AuthConstants.failedToPushImageToStorage)))
                    return
                }
                
                ref.downloadURL { url, error in
                    if let _ = error {
                        promise(.failure(AppError(message: AuthConstants.failedToRetrieveDownloadURL)))
                        return
                    }
                    
                    guard let url = url else {
                        promise(.failure(AppError(message: AuthConstants.failedToRetrieveURL)))
                        return
                    }
                    
                    promise(.success(url))
                }
            }
        }
    }
    
    func storeUserInformation(request: UserRequest) -> Future<Bool, Error> {
        return Future { promise in
            FirebaseManager.shared.firestore
                .collection(AuthConstants.users)
                .document(request.uid)
                .setData(request.dictionary) { error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    promise(.success(true))
                }
        }
    }
}
