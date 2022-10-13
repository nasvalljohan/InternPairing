import Foundation
import Firebase

class DataManager: ObservableObject {
    
    @Published var userInterns = [UserIntern]()
    @Published var userRecruiters = [UserRecruiter]()
    init() {
        fetchUserInterns()
    }
    
    // MARK:  NOT YET IMPLEMENTED
    func addUserInternPage1(dateOfBirth: Date, firstName: String, lastName: String, gender: String) {
        let db = Firestore.firestore()
        let reference = db.collection("UserInterns").document("user")
        
        reference.setData([
            "dateOfBirth": dateOfBirth,
            "firstName": firstName,
            "lastName": lastName,
            "gender": gender
        ]) {
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUserInterns() {
        userInterns.removeAll()
        let db = Firestore.firestore()
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
                    
                    let id = data["id"] as? String ?? ""
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
}
