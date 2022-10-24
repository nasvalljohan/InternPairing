import Foundation

protocol UserProtocol: Identifiable {
    static var id: String { get }
    static var name: String { get }
    static var age: Int { get }
    static var location: String { get }
    static var email: String { get }
    static var phoneNumber: Int { get }
}
