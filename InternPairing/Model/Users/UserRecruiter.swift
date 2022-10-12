import Foundation
import FirebaseFirestoreSwift

struct UserRecruiter: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var location: String
    var email: String
    var phoneNumber: Int
}
