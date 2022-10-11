import SwiftUI
import Firebase

@main
struct InternPairingApp: App {
    
    @StateObject var dataManager = DataManager()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            UserView()
//                .environmentObject(dataManager)
        }
    }
}
