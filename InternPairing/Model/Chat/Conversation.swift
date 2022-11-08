import Foundation
import FirebaseFirestoreSwift

class Conversation: Identifiable, Codable {
    @DocumentID var id: String?
    var uid: UUID
    var name: String
    var members: [TheUser]
    var messages: [Message]
    
    init(name: String, members: [TheUser]) {
        
        self.uid = UUID()
        self.name = name
        self.members = members
        self.messages = [Message]()
        
    }
    
    //    init(uid: UUID, name: String, members: [TheUser], messages: [Message] ) {
    //
    //        self.uid = uid
    //        self.name = name
    //        self.members = members
    //        self.messages = messages
    //
    //    }
    
}
