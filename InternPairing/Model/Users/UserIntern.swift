import Foundation
import FirebaseFirestoreSwift

struct UserIntern: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var age: Int
    
    //Conform to identifiable
//    var location: String
//    var email: String
//    var phoneNumber: Int
}
