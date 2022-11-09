
import Firebase
import Foundation

class UserManager: ObservableObject {
    @Published var swipeableInternsArray: Array<TheUser> = []
    @Published var theUser: TheUser?
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    @Published var selected = 0
    
    //some go to convomanager
    @Published var contactsUidArray: Array<String> = []
    @Published var contactsArray: Array<TheUser> = []
    @Published var conversationsArray: Array<Conversation> = []
        
    init() {
        do {
            try Auth.auth().signOut()
        }
        catch { print("logged out") }
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
    
    //MARK: Auth
    func registerUser(email: String, password: String, dateOfBirth: Date, firstName: String, lastName: String, companyName: String, isUserComplete: Bool) {
        var role = ""
        if selected == 1 {
            role = "Intern"
        }
        if selected == 2 {
            role = "Recruiter"
        }
        
            print("hll")
            dm.registerUser(email: email, password: password, dateOfBirth: dateOfBirth, firstName: firstName, lastName: lastName, companyName: companyName, isUserComplete: isUserComplete, role: role, selected: selected)
        
    }
    
    func login(email: String, password: String) {
        dm.loginUser(email: email, password: password)
    }

    
    //MARK: Push
    func pushUserDetails(firstName: String, lastName: String, companyName: String, description: String, linkedInLink: String, otherLink: String, location: String, githubLink: String, typeOfDeveloper: Int, companyLink: String){
        if let currentUser = currentUser,
           let theUser = theUser {
            dm.pushUserDetails(firstName: firstName, lastName: lastName, companyName: companyName, description: description, linkedInLink: linkedInLink, otherLink: otherLink, location: location, githubLink: githubLink, typeOfDeveloper: typeOfDeveloper, companyLink: companyLink, user: theUser, currentUser: currentUser)
        }
    }
    
    func pushToContactsArray(intern: String){
        if let currentUser = currentUser {
            dm.pushToContactsArray(intern: intern, currentUser: currentUser)
        }
    }
    
    func pushImage(imageUrl: String) {
        if let currentUser = currentUser {
            dm.pushImage(imageUrl: imageUrl, currentUser: currentUser)
        }
    }
    
    //MARK: Fetch
    func fetchCurrentUser(){
        if let currentUser = currentUser,
           let theUser = theUser {
            var xUser = dm.fetchCurrentUser(currentUser: currentUser, theUser: theUser)
            contactsUidArray = xUser.contacts ?? []
        }
    }
    
    func fetchInterns() {
        if let theUser = theUser {
            var xUser = dm.fetchInterns(theUser: theUser)
            
            for contact in contactsUidArray {
                if !contactsUidArray.contains(contact) {
                    swipeableInternsArray.append(xUser)
                }
            }
        }
    }
    
    func fetchContacts(){
        var xUsers = dm.fetchContacts(contactsUidArray: contactsUidArray)
        for user in xUsers {
            contactsArray.append(user)
        }
    }
}
