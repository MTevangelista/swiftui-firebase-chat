import Combine

class MessageRemoteDataSource {
    static var shared: MessageRemoteDataSource = MessageRemoteDataSource()
    
    private init() {}
    
    func fetchCurrentUser() -> Future<[String : Any], AppError> {
        return Future { promise in
            guard let uid = FirebaseManager.getUID() else {
                promise(.failure(AppError(message: FirebaseConstants.ErrorMessage.couldNotFindFirebaseUID)))
                return
            }
            
            FirebaseManager.shared.firestore
                .collection(FirebaseConstants.Collection.users)
                .document(uid)
                .getDocument { snapshot, error in
                    if let error = error {
                        promise(.failure(AppError(message: error.localizedDescription)))
                        return
                    }
                    
                    guard let data = snapshot?.data() else {
                        promise(.failure(AppError(message: MessageConstants.ErrorMessage.noDataFound)))
                        return
                    }
                    
                    promise(.success(data))
                }
        }
    }
}
