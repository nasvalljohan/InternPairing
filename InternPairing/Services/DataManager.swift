import Foundation
import Firebase

class DataManager {
    private var db = Firestore.firestore()
    private let usersCollection = "Users"
    private let conversationsCollection = "Conversations"
    private var userDocumentListener: ListenerRegistration? // nil as long as user is logged out
    
    // MARK: Auth functions
    // Register
    func registerUser(email: String, password: String, dateOfBirth: Date?, firstName: String?, lastName: String?, companyName: String?, isUserComplete: Bool, role: String, selected: Int) {
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
                
                if selected == 1 {
                    userRole = "Intern"

                    newUser = TheUser(
                        id: authDataResult.user.uid,
                        role: userRole,
                        firstName: firstName,
                        lastName: lastName,
                        dateOfBirth: dateOfBirth
                    )
                }
                if selected == 2 {

                    newUser = TheUser(
                        id: authDataResult.user.uid,
                        role: userRole,
                        firstName: firstName,
                        lastName: lastName,
                        contacts: [],
                        companyName: companyName
                    )
                }
                
                // Firestore: Set new document to uid and set data from newUserIntern.
                do {
                    try self.db.collection(self.usersCollection)
                        .document(authDataResult.user.uid)
                        .setData(from: newUser)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Login
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            print("trying to log in")
        }
    }
    
    // MARK: Push to db functions
    
    // Adds values from UserDetailsView to db
    func pushUserDetails(firstName: String, lastName: String, companyName: String, description: String, linkedInLink: String, otherLink: String, location: String, githubLink: String, typeOfDeveloper: Int, companyLink: String, user: TheUser, currentUser: User) {
            let reference = db.collection(usersCollection).document(currentUser.uid)
            if user.role == "Recruiter" {
                reference.updateData([
                    "firstName": firstName,
                    "lastName": lastName,
                    "companyName": companyName,
                    "companyLink": companyLink,
                    "description": description,
                    "linkedInLink": linkedInLink,
                    "location": location,
                    "typeOfDeveloper": typeOfDeveloper,
                    "isUserComplete": true,
                ]) {
                    error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            if user.role == "Intern" {
                reference.updateData([
                    "firstName": firstName,
                    "lastName": lastName,
                    "description": description,
                    "isUserComplete": true,
                    "linkedInLink": linkedInLink,
                    "githubLink": githubLink,
                    "otherLink": otherLink,
                    "location": location,
                    "typeOfDeveloper": typeOfDeveloper,
                ]) {
                    error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        
    }
    
    func pushImage(imageUrl: String, currentUser: User) {
            let reference = db.collection(usersCollection).document(currentUser.uid)
            reference.updateData([
                "imageUrl": imageUrl
            ])
    }
    
    // Adds intern uid to recruiter document
    func pushToContactsArray(intern: String, currentUser: User) {
            let referenceRecruiter = db.collection(usersCollection).document(currentUser.uid)
            let referenceIntern = db.collection(usersCollection).document(intern)
            
            referenceRecruiter.updateData([
                "contacts": FieldValue.arrayUnion([intern])
            ])
            
            referenceIntern.updateData([
                "contacts": FieldValue.arrayUnion([currentUser.uid])
            ])
    }
    
    
    // MARK: Fetch from db functions
        
    // fetches the current user that's logged in
    func fetchCurrentUser(currentUser: User, theUser: TheUser) -> TheUser {
        var temp: TheUser = theUser
        
            userDocumentListener = self.db
                .collection(usersCollection)
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
                        temp = theUser
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                }
        return temp
    }
    
    // fetches interns that recruiter hasn't matched with
    func fetchInterns(theUser: TheUser) -> TheUser{
        
        var temp: TheUser = theUser
        
        db.collection(self.usersCollection).whereField("isUserComplete", isEqualTo: true).whereField("role", isEqualTo: "Intern")
            .getDocuments() { (querySnapshot, error) in
                
                if let error = error {
                    print("\(error) getting documents: (err)")
                } else {
                    
                    // convert the querySnapshots to TheUser format
                    for document in querySnapshot!.documents {
                        do {
                            let user = try document.data(as: TheUser.self)
                            
                            temp = user
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        return temp
    }
    
    // Fetching contacts for both recruiter and intern
    func fetchContacts(contactsUidArray: [String]) -> [TheUser] {
    
        var tempArray: [TheUser] = []
        
        db.collection(self.usersCollection).whereField("isUserComplete", isEqualTo: true).getDocuments() { (querySnapshot, error) in
            
                if let error = error {
                    print("\(error) getting documents: (err)")
                } else {
                    
                    // convert the querySnapshots to TheUser format
                    for uid in contactsUidArray {
                        for document in querySnapshot!.documents {
                            if uid == document.documentID {
                                do {
                                    let user = try document.data(as: TheUser.self)
                                    
                                    tempArray.append(user)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }

                }
            }
        return tempArray
    }
    
    // MARK: Chat
    
}

