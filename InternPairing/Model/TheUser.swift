
import Foundation
import FirebaseFirestoreSwift

struct TheUser: Codable, Identifiable, Hashable {
    
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
    var imageUrl: String?
    
    //MARK: Recruiter variables
    var companyName: String?
    var companyLink: String?
    var likedInterns: Array<String>?
    
    //MARK: Student variables
    var firstName: String?
    var lastName: String?
    var dateOfBirth: Date?
    var gender: String?
    
}
