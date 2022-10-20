import Foundation
import Firebase

class DatabaseConnection: ObservableObject {
    private var db = Firestore.firestore()
    
    // Arrays of users
//    @Published var userIntern: UserIntern?
//    @Published var userRecruiter: UserRecruiter?
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
                
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
            }
        }
    }

    
    // MARK: Register Intern
    func registerUserIntern(email: String, password: String,dateOfBirth: Date, firstName: String, lastName: String, gender: String) {
       
        // AUTH: call
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            // AUTH: If successfull
            if let authDataResult = authDataResult {
                let newUserIntern = UserIntern(id: authDataResult.user.uid, isUserComplete: false, role: "student",firstName: firstName,lastName: lastName,dateOfBirth: Date() ,gender: gender,description: "",linkedInLink: "",githubLink: "",otherLink: "",location: "",typeOfDeveloper: "",typeOfPosition: ""
                )
                
                // Firestore: Set new document to uid and set data from newUserIntern.
                do {
                    try self.db.collection("UserInterns")
                        .document(authDataResult.user.uid)
                        .setData(from: newUserIntern)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        // Firestore: Set more values from user input
        if let currentUser = currentUser {
            let reference = db.collection("UserInterns").document(currentUser.uid)
            
            reference.setData([
                "firstName": firstName,
                "lastName": lastName,
            ]) {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
    // MARK: Register Recruiter
    
    func registerUserRecruiter(email: String, password: String, companyName: String) {
       
        // AUTH: Call
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            // AUTH: If successful
            if let authDataResult = authDataResult {
                let newUserIntern = UserRecruiter(id: authDataResult.user.uid, isUserComplete: false, role: "recruiter", companyName: companyName, description: "", linkedInLink: "", companyLink: "", location: "", typeOfDeveloper: "", typeOfPosition: "")
                
                // Firestore: Set new document to uid and set data from newUserIntern.
                do {
                    try self.db.collection("UserRecruiters")
                        .document(authDataResult.user.uid)
                        .setData(from: newUserIntern)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        // Firestore: Set more values from user input
        if let currentUser = currentUser {
            let reference = db.collection("UserRecruiters").document(currentUser.uid)
            
            reference.setData([
                "companyName": companyName,
            ]) {
                error in
                if let error = error {
                    print(error.localizedDescription)
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
