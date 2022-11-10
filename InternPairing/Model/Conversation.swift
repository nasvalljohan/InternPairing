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
    var members: [String]
    var messages: [Message]
  

    
    init(uid: UUID, members: [String], messages: [Message] ) {

        self.uid = uid

        self.members = members
        self.messages = messages
    }
}
