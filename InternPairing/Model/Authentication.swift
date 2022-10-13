import Foundation
import Firebase

struct Authentication {
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print("UID: \(userID)")
    }

    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
