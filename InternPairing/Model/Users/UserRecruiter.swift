import Foundation
import FirebaseFirestoreSwift

struct UserRecruiter: Codable, Identifiable {
    @DocumentID var id: String?
    var isUserComplete: Bool
    var role: String
    var companyName: String
    
    // profile sign up
    var description: String
    var linkedInLink: String
    var companyLink: String
    
    // MATCHING STUDENTS
    var location: String
    var typeOfDeveloper: String
    var typeOfPosition: String
}
