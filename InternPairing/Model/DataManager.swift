import Foundation
import Firebase

class DataManager: ObservableObject {
    
    @Published var userInterns = [UserIntern]()
    @Published var userRecruiters = [UserRecruiter]()
    init() {
        fetchUsers(typeOfUser: "UserInterns")
    }
    
    // MARK:  NOT YET IMPLEMENTED
    func addUser() {
        let db = Firestore.firestore()
        let reference = db.collection("UserInterns").document("user")
        reference.setData(["age": 10, "name": "johan", "id": "IDHANDLING"]) {
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUsers(typeOfUser: String) {
        userInterns.removeAll()
        let db = Firestore.firestore()
        let reference = db.collection(typeOfUser)
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
                    let age = data["age"] as? Int ?? -1
                    let name = data["name"] as? String ?? ""
                    
                    let user = UserIntern(id: id, name: name, age: age)
                    self.userInterns.append(user)
                }
            }
            
        }
    }
}
