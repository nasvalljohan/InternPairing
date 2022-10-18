import Foundation
import Firebase

class DatabaseConnection: ObservableObject {
    private var db = Firestore.firestore()
    
    // Arrays of users
    @Published var userIntern: UserIntern?
    @Published var userRecruiter: UserRecruiter?
    
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    
    // nil as long as user is logged out
    var userDocumentListener: ListenerRegistration?
    
    init() {
        // to see if user is logged in or not
        do {
            try Auth.auth().signOut()
        } catch {
            print("logged out")
        }
        
        Auth.auth().addStateDidChangeListener {
            auth, user in
            
            if let user = user {
                self.userLoggedIn = true
                self.currentUser = user
//                self.fetchUserInterns()
                
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
                //                self.stopListenToDatabase()
            }
        }
    }

    
    // MARK: Register User Intern
    func registerUserIntern(email: String, password: String,dateOfBirth: Date, firstName: String, lastName: String, gender: String) {
       
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let authDataResult = authDataResult {
                let newUserIntern = UserIntern(
                    id: authDataResult.user.uid,
                    firstName: firstName,
                    lastName: lastName,
                    dateOfBirth: Date(),
                    gender: gender,
                    description: "",
                    linkedInLink: "",
                    githubLink: "",
                    otherLink: "",
                    location: "",
                    typeOfDeveloper: "",
                    typeOfPosition: ""
                )
                
                
                do {
                    try self.db.collection("UserInterns")
                        .document(authDataResult.user.uid)
                        .setData(from: newUserIntern)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        if let currentUser = currentUser {
            let reference = db.collection("UserInterns").document(currentUser.uid)
            
            reference.setData([
                //            "dateOfBirth": dateOfBirth,
                "firstName": firstName,
                "lastName": lastName,
                //            "gender": gender
            ]) {
                error in
                if let error = error {
                    print(error.localizedDescription)
                    print("")
                }
            }
        }
    }
    
    // MARK: LoginUser
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
// MARK: TODO:
// add read function
    
    
    // Implement this for details
//    func addUserInternDetails() {
//        if let currentUser = currentUser {
//            let reference = db.collection("UserInterns").document(currentUser.uid)
//
//            reference.updateData([
//                // Detail data
//            ]) {
//                error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    print("")
//                }
//            }
//        }
//    }
    
    
}
