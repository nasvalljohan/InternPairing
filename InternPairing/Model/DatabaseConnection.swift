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
    var internDocumentListener: ListenerRegistration?
    var recruiterDocumentListener: ListenerRegistration?
    
    
    init() {
        
        // to see if user is logged in or not
        Auth.auth().addStateDidChangeListener {
            auth, user in
            
            if let user = user {
                self.userLoggedIn = true
                self.currentUser = user
                self.fetchUserIntern()
                self.fetchUserRecruiter()
                
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
                self.stopListenToDatabase()
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
                let newUserIntern = UserIntern(id: authDataResult.user.uid, isUserComplete: false, role: "student", firstName: firstName, lastName: lastName, dateOfBirth: Date(), gender: gender, description: "", linkedInLink: "", githubLink: "", otherLink: "", location: "", typeOfDeveloper: "", typeOfPosition: ""
                )
                
                // Firestore: Set new document to uid and set data from newUserIntern.
                do {
                    try self.db.collection("UserInterns")
                        .document("intern" + authDataResult.user.uid)
                        .setData(from: newUserIntern)
                } catch {
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
                let newUserRecruiter = UserRecruiter(id: authDataResult.user.uid, isUserComplete: false, role: "recruiter", companyName: companyName, description: "", linkedInLink: "", companyLink: "", location: "", typeOfDeveloper: "", typeOfPosition: "")
                
                // Firestore: Set new document to uid and set data from newUserIntern.
                do {
                    try self.db.collection("UserRecruiters")
                        .document("recruiter" + authDataResult.user.uid)
                        .setData(from: newUserRecruiter)
                } catch {
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
    
    //MARK: fetchUserIntern
    func fetchUserIntern() {
        if let currentUser = currentUser {
            internDocumentListener = self.db
                .collection("UserInterns")
                .document("intern" + currentUser.uid)
                .addSnapshotListener {
                    snapshot, error in
                    if let error = error {
                        print("intern " + error.localizedDescription)
                        return
                    }
                    
                    guard let snapshot = snapshot else { return }
                    
                    let result = Result {
                        try snapshot.data(as: UserIntern.self)
                    }
                    
                    switch result {
                    case .success(let userIntern):
                        self.userIntern = userIntern
                        break
                    case .failure(let error):
                        print("intern " + error.localizedDescription)
                        break
                    }
                }
        }
    }
    
    //MARK: fetchUserRecruiter
    func fetchUserRecruiter() {
        if let currentUser = currentUser {
            internDocumentListener = self.db
                .collection("UserRecruiters")
                .document("recruiter" + currentUser.uid)
                .addSnapshotListener {
                    snapshot, error in
                    if let error = error {
                        print("recruiter " + error.localizedDescription)
                        return
                    }
                    
                    guard let snapshot = snapshot else { return }
                    
                    let result = Result {
                        try snapshot.data(as: UserRecruiter.self)
                    }
                    
                    switch result {
                    case .success(let userRecruiter):
                        self.userRecruiter = userRecruiter
                        break
                    case .failure(let error):
                        print("recruiter " + error.localizedDescription)
                        break
                    }
                }
        }
    }
    
    func stopListenToDatabase() {
        if let internDocumentListener = internDocumentListener,
           let recruiterDocumentListener = recruiterDocumentListener {
            internDocumentListener.remove()
            recruiterDocumentListener.remove()
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
