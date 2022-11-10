import Foundation
import Firebase

class DataManager: ObservableObject {
    var db = Firestore.firestore()
    
    // Published variables
    private let usersCollection = "Users"
    private let conversationsCollection = "Conversations"
    
    @Published var swipeableInternsArray: Array<TheUser> = []
    @Published var contactsUidArray: Array<String> = []
    @Published var contactsArray: Array<TheUser> = []
    @Published var conversationsArray: Array<Conversation> = []
    @Published var selected = 1
    @Published var theUser: TheUser?
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    var userDocumentListener: ListenerRegistration? // nil as long as user is logged out
    
    // Init - listening for changes in authstate
    init() {
        do {try Auth.auth().signOut() }
        catch { print("logged out") }
        Auth.auth().addStateDidChangeListener {
            auth, user in
            if let user = user {
                self.userLoggedIn = true
                self.currentUser = user
                self.fetchCurrentUser()
                self.fetchInterns()
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
    
    
    // MARK: Auth functions
    
    // Register
    func registerUser(email: String, password: String, dateOfBirth: Date?, firstName: String?, lastName: String?, companyName: String?, isUserComplete: Bool) {
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
                    
                    newUser = TheUser(
                        id: authDataResult.user.uid,
                        role: userRole,
                        firstName: firstName,
                        lastName: lastName,
                        dateOfBirth: dateOfBirth
                    )
                } else if self.selected == 2 {
                    userRole = "Recruiter"
                    
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
        }
    }
    
    // MARK: Push to db functions
    
    // Adds values from UserDetailsView to db
    func pushUserDetails(firstName: String, lastName: String, companyName: String, description: String, linkedInLink: String, otherLink: String, location: String, githubLink: String, typeOfDeveloper: Int, companyLink: String) {
        if let currentUser = currentUser {
            let reference = db.collection(usersCollection).document(currentUser.uid)
            
            if theUser?.role == "Recruiter" {
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
            
            if theUser?.role == "Intern" {
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
    }
    
    func pushImage(imageUrl: String) {
        if let currentUser = currentUser {
            let reference = db.collection(usersCollection).document(currentUser.uid)
            
            reference.updateData([
                "imageUrl": imageUrl
            ])
        }
    }
    
    // Adds intern uid to recruiter document
    func pushToContactsArray(intern: String) {
        if let currentUser = currentUser {
            
            let referenceRecruiter = db.collection(usersCollection).document(currentUser.uid)
            let referenceIntern = db.collection(usersCollection).document(intern)
            
            referenceRecruiter.updateData([
                "contacts": FieldValue.arrayUnion([intern]),
            ])
            
            referenceIntern.updateData([
                "contacts": FieldValue.arrayUnion([currentUser.uid]),
            ])
        }
    }
    
    
    // MARK: Fetch from db functions
    
    // fetches the current user that's logged in
    func fetchCurrentUser() {
        self.contactsUidArray.removeAll()
        if let currentUser = currentUser {
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
                        self.theUser = theUser
                        self.contactsUidArray = theUser.contacts ?? []
                        
                        print("1. ContactsUIDArray: \(self.contactsUidArray.count)")
                        
                        self.fetchContacts()
                        self.fetchConversations()
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                }
        }
    }
    
    // fetches interns that recruiter hasn't matched with
    func fetchInterns() {
        
        self.swipeableInternsArray.removeAll()
        
        db.collection(self.usersCollection).whereField("isUserComplete", isEqualTo: true).whereField("role", isEqualTo: "Intern")
            .getDocuments() { (querySnapshot, error) in
                
                if let error = error {
                    print("\(error) getting documents: (err)")
                } else {
                    
                    // convert the querySnapshots to TheUser format
                    for document in querySnapshot!.documents {
                        do {
                            let user = try document.data(as: TheUser.self)
                            
                            if !self.contactsUidArray.contains(user.id ?? "") {
                                self.swipeableInternsArray.append(user)
                            }
                            
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
    
    // Fetching contacts for both recruiter and intern
    func fetchContacts() {
        self.contactsArray.removeAll()
        db.collection(self.usersCollection).whereField("isUserComplete", isEqualTo: true)
            .getDocuments() { (querySnapshot, error) in
                
                if let error = error {
                    print("\(error) getting documents: (err)")
                } else {
                    
                    // convert the querySnapshots to TheUser format
                    for uid in self.contactsUidArray {
                        for document in querySnapshot!.documents {
                            if uid == document.documentID {
                                do {
                                    let user = try document.data(as: TheUser.self)
                                    self.contactsArray.append(user)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                    
                    print("3. ContactsArray: \(self.contactsArray.count)")
                }
            }
    }
    
    // MARK: ------------------------------------------------------------------------------
    
  
    
    
    
    
    // MARK: Chat
    
    func pushNewConversation(conversation: Conversation) {
        // NOT DONE
        do {
            _ = try db.collection(conversationsCollection).document("\(conversation.uid)").setData(from: conversation)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchConversations() {
        self.conversationsArray.removeAll()
        db.collection(self.conversationsCollection)
            .whereField("members", arrayContains: theUser?.id)
            .getDocuments() { (querySnapshot, error) in
                
                if let error = error {
                    print("\(error) getting documents: (err)")
                } else {
                    
                    for document in querySnapshot!.documents {
                        do {
                            let conversation = try document.data(as: Conversation.self)
                            self.conversationsArray.append(conversation)
                            print("This is the conversation: \(self.conversationsArray)")
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                }
            }
        
    }
    // Add listener to the function aswell
    // push new messages
    
    // fetch new messages
}

