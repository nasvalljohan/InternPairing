import SwiftUI
import FirebaseAuth

// MARK: ContentView
struct ContentView: View {
    @StateObject var databaseConnection = DatabaseConnection()
    
    var body: some View {
        VStack {
            if databaseConnection.userLoggedIn {
                if databaseConnection.userRecruiter?.role == "recruiter" {
                    Text(databaseConnection.userRecruiter?.companyName ?? "")
                        TabViewRecruiter(databaseConnection: databaseConnection)
                } else if databaseConnection.userIntern?.role == "student" {
                    Text(databaseConnection.userIntern?.firstName ?? "")
                        TabViewStudent(databaseConnection: databaseConnection)
                    }
                } else{
                    LoginView()
                }
                
//                Button(action: {
//                    do {
//                        try Auth.auth().signOut()
//                    } catch {
//                        print("logged out")
//                    }
//                }, label: {
//                    Text("Logga ut")
//                })
            
        }
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum NavigationType: String, Hashable {
    case swipe = "SWIPE VIEW"
    case contact = "CONTACT VIEW"
    case profile = "PROFILE VIEW"
}

// MARK: TabViewRecruiter
struct TabViewRecruiter: View {
    @ObservedObject var databaseConnection: DatabaseConnection
    @State var mainStack: [NavigationType] = []
    
    var body: some View {
        NavigationStack(path: $mainStack){
            TabView{
                Text("this is the home page")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                SwipeView()
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                Text("Contacts").tabItem{
                    Image(systemName: "message.fill")
                }
                ProfileView(databaseConnection: databaseConnection)
                    .tabItem{
                    Image(systemName: "person.circle")
                }
                
            }
            .navigationTitle("Jinder")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationDestination(for: NavigationType.self) { value in
//                switch(value){
//                //case .swipe: SignUpView()
//                case .contact: Text("Contact view")
//                case .profile: Text("Profile view!!")
//                }
//            }
        }
    }
}

// MARK: TabViewStudent
struct TabViewStudent: View {
    @State var mainStack: [NavigationType] = []
    @ObservedObject var databaseConnection: DatabaseConnection
    
    var body: some View {
        NavigationStack(path: $mainStack){
            TabView{
                Text("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                ProfileView(databaseConnection: databaseConnection)
                    .tabItem{
                        Image(systemName: "person.circle")
                    }
                Text("Contacts")
                    .tabItem{
                        Image(systemName: "message.fill")
                    }
            }
            .navigationTitle("Jinder")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



