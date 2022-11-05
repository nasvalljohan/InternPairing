
import Foundation
import FirebaseFirestoreSwift

struct TheUser: Codable, Identifiable, Hashable {
    
    //MARK: Shared variables
    @DocumentID var id: String?
    var isUserComplete = false
    var role: String?
    var firstName: String?
    var lastName: String?
    var description: String?
    var linkedInLink: String?
    var githubLink: String?
    var otherLink: String?
    var location: String?
    var typeOfDeveloper: Int?
    var imageUrl: String?
    var contacts: Array<String>?
    
    //MARK: Recruiter variables
    var companyName: String?
    var companyLink: String?
    
    
    //MARK: Student variables
    var dateOfBirth: Date?
    var gender: String?
    
    
    //TODO: collect recruitername to show on profile.
    
    
}
