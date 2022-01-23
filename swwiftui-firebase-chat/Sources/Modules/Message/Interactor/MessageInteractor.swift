import Combine

struct MessageInteractor {
    let remote: MessageRemoteDataSource = .shared
    
    func fetchCurrentUser() -> Future<[String : Any], AppError> {
        return remote.fetchCurrentUser()
    }
}
