import Foundation
import Firebase

struct Autentication {
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func isUserLoggedIn(isUserLoggedIn: Bool) {
        var userLogged = isUserLoggedIn
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                userLogged.toggle()
            }
        }
    }
}
