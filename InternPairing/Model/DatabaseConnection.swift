import Foundation
import Firebase

class DatabaseConnection: ObservableObject {
    private var db = Firestore.firestore()
    
    // Arrays of users
    @Published var userInterns = [UserIntern]()
    @Published var userRecruiters = [UserRecruiter]()
    
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
                self.fetchUserInterns()
                
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
//                self.stopListenToDatabase()
            }
        }
    }
    
    // MARK:  NOT YET IMPLEMENTED
    // MARK: Firebase
    func addUserInternPage1(dateOfBirth: Date, firstName: String, lastName: String, gender: String) {
        
        let reference = db.collection("UserInterns").document("user")
        
        reference.setData([
//            "dateOfBirth": dateOfBirth,
            "firstName": firstName,
            "lastName": lastName,
//            "gender": gender
        ]) {
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUserInterns() {
        userInterns.removeAll()
        let reference = db.collection("UserInterns")
        reference.getDocuments {
            snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let dateOfBirth = data["dateOfBirth"] as? Date ?? Date()
                    let gender = data["gender"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let linkedInLink = data["linkedInLink"] as? String ?? ""
                    let githubLink = data["githubLink"] as? String ?? ""
                    let otherLink = data["otherLink"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let typeOfDeveloper = data["typeOfDeveloper"] as? String ?? ""
                    let typeOfPosition = data["typeOfPosition"] as? String ?? ""
                    
                    let user = UserIntern(firstName: firstName,
                                          lastName: lastName,
                                          dateOfBirth: dateOfBirth,
                                          gender: gender,
                                          description: description,
                                          linkedInLink: linkedInLink,
                                          githubLink: githubLink,
                                          otherLink: otherLink,
                                          location: location,
                                          typeOfDeveloper: typeOfDeveloper,
                                          typeOfPosition: typeOfPosition)
                    
                    self.userInterns.append(user)
                }
            }
            
        }
    }
    
    // MARK: Authentication
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
