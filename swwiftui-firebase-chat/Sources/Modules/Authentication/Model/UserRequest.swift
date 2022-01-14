import Foundation

struct UserRequest {
    let uid: String
    let photoURL: URL
    let email: String
    let password: String
    
    var dictionary: [String: Any] {
        return [
            "uiid": uid,
            "photoURL": photoURL.absoluteString,
            "email": email,
            "password": password
        ]
    }
}
