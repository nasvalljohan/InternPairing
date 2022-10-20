import Foundation
import FirebaseFirestoreSwift

struct UserIntern: Codable, Identifiable {
    @DocumentID var id: String?
    var isUserComplete: Bool
    var role: String
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var gender: String
    
    // profileSignup
    var description: String
    var linkedInLink: String
    var githubLink: String
    var otherLink: String
    
    // MATCHING RECRUITERS
    var location: String
    var typeOfDeveloper: String
    var typeOfPosition: String
}
