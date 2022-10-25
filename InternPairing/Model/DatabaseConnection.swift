import Foundation
import Firebase

class DatabaseConnection: ObservableObject {
    private var db = Firestore.firestore()
    
    // Published variables
    private let collection = "Users"
    @Published var fetchedArray: Array<TheUser> = []
    @Published var selected = 1
    @Published var theUser: TheUser?
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    
    // nil as long as user is logged out
    var userDocumentListener: ListenerRegistration?
    
    init() {
        do {try Auth.auth().signOut() }
        catch { print("logged out") }
        
        Auth.auth().addStateDidChangeListener {
            auth, user in
            
            if let user = user {
                self.userLoggedIn = true
                self.currentUser = user
                self.fetchTheUser()
                self.fetchSwipeableStudents()
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
                self.stopListenToDatabase()
            }
        }
    }
    
    //MARK: Listener
    func stopListenToDatabase() {
        if let userDocumentListener = userDocumentListener {
            userDocumentListener.remove()
        }
    }
    
    
    // MARK: Register user
    func registerTheUser(email: String, password: String, dateOfBirth: Date?, firstName: String?, lastName: String?, gender: String?, companyName: String?, isUserComplete: Bool) {
        var userRole = ""
        var newUser: TheUser?
        
        // AUTH: call
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            // AUTH: If successfull
            if let authDataResult = authDataResult {
                
                if self.selected == 1 {
                    userRole = "Intern"
                    newUser = TheUser(id: authDataResult.user.uid, role: userRole, firstName: firstName, lastName: lastName, dateOfBirth: Date(), gender: gender)
                } else if self.selected == 2 {
                    userRole = "Recruiter"
                    newUser = TheUser(id: authDataResult.user.uid, role: userRole, companyName: companyName, likedInterns: [])
                }
                
                // Firestore: Set new document to uid and set data from newUserIntern.
                do {
                    try self.db.collection(self.collection)
                        .document(authDataResult.user.uid)
                        .setData(from: newUser)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: Login User
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    // MARK: Add user details
    func addUserDetails(description: String, linkedInLink: String, otherLink: String, location: String, githubLink: String, typeOfDeveloper: Int, typeOfPosition: Int, companyLink: String) {
        if let currentUser = currentUser {
            let reference = db.collection(collection).document(currentUser.uid)
            
            if selected == 1{
                reference.updateData([
                    "description": description,
                    "githubLink": githubLink,
                    "linkedInLink": linkedInLink,
                    "location": location,
                    "otherLink": otherLink,
                    "typeOfDeveloper": typeOfDeveloper,
                    "typeOfPosition":typeOfPosition,
                    "isUserComplete": true
                ]) {
                    error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            } else if selected == 2 {
                reference.updateData([
                    "companyLink": companyLink,
                    "description": description,
                    "isUserComplete": true,
                    "linkedInLink": linkedInLink,
                    "location": location,
                    "typeOfDeveloper": typeOfDeveloper,
                    "typeOfPosition": typeOfPosition,
                ]) {
                    error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // MARK: addToLikedInternArr
    func addToLikedInternArr(intern: Any) {
        if let currentUser = currentUser {
            let reference = db.collection(collection).document(currentUser.uid)
            reference.updateData([
                "likedInterns": FieldValue.arrayUnion([intern])
            ])
        }
    }
    
    // MARK: fetchSwipeableStudents
    func fetchSwipeableStudents() {
        
        db.collection(self.collection).whereField("isUserComplete", isEqualTo: true && "role" != "Recruiter")
            .getDocuments() { (querySnapshot, error) in
                
                if let error = error {
                    print("\(error) getting documents: (err)")
                } else {
                    
                    // convert the querySnapshots to TheUser format
                    for document in querySnapshot!.documents {
                        do {
                            let user = try document.data(as: TheUser.self)
                            self.fetchedArray.append(user)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    print(self.fetchedArray)
                }
            }
    }
    
    //MARK: fetchUser
    func fetchTheUser() {
        if let currentUser = currentUser {
            userDocumentListener = self.db
                .collection(collection)
                .document(currentUser.uid)
                .addSnapshotListener {
                    snapshot, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let snapshot = snapshot else { return }
                    
                    let result = Result {
                        try snapshot.data(as: TheUser.self)
                    }
                    
                    switch result {
                    case .success(let theUser):
                        self.theUser = theUser
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                }
        }
    }
}
