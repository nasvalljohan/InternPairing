import Foundation

struct Message: Identifiable, Codable, Hashable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
