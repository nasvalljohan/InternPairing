
import Foundation
import FirebaseFirestoreSwift

struct TheUser: Codable, Identifiable {
    
    //MARK: Shared variables
    @DocumentID var id: String?
    var isUserComplete = false
    var role: String?
    var description: String?
    var linkedInLink: String?
    var githubLink: String?
    var otherLink: String?
    var location: String?
    var typeOfDeveloper: Int?
    var typeOfPosition: Int?
    
    //MARK: Recruiter variables
    var companyName: String?
    var companyLink: String?
    
    //MARK: Student variables
    var firstName: String?
    var lastName: String?
    var dateOfBirth: Date?
    var gender: String?
    
}
