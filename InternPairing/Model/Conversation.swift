import Foundation
import FirebaseFirestoreSwift

/*
 - user id
    - recruiter
    - intern
 
 - user firstname, lastname
    - recruiter
    - intern
 
 - user image
    - recruiter
    - intern
 
 - array of messages
 
 - uid for document name
 */

struct Conversation: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var uid: UUID
    var recruiterFirstname: String
    var recruiterLastname: String
    var internFirstname: String
    var internLastname: String
    var recruiterImage: String
    var internImage: String
    var members: [String]
    var messages: [Message]
  

    
    init(uid: UUID, recruiterFirstname: String, recruiterLastname: String, internFirstname: String, internLastname: String, recruiterImage: String, internImage: String, members: [String], messages: [Message] ) {

        self.uid = uid
        self.recruiterFirstname = recruiterFirstname
        self.recruiterLastname = recruiterLastname
        self.internFirstname = internFirstname
        self.internLastname = internLastname
        self.recruiterImage = recruiterImage
        self.internImage = internImage
        self.members = members
        self.messages = messages
    }
}
