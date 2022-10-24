import SwiftUI
import FirebaseAuth

// MARK: ContentView
struct ContentView: View {
    @StateObject var databaseConnection: DatabaseConnection = DatabaseConnection()
    
    var body: some View {
        VStack {
            if databaseConnection.userLoggedIn {
                if databaseConnection.theUser?.role == "Recruiter" {
                    if databaseConnection.theUser?.isUserComplete == false{
                        UserDetailsView()
                    }else {
                        Text(databaseConnection.theUser?.companyName ?? "")
                        TabViewRecruiter()
                    }
                    
                } else if databaseConnection.theUser?.role == "Intern" {
                    if databaseConnection.theUser?.isUserComplete == false {
                        UserDetailsView()
                    } else {
                        Text(databaseConnection.theUser?.firstName ?? "")
                        TabViewStudent()
                    }
                    
                }
            } else{
                LoginView()
            }
                
        }.environmentObject(databaseConnection)
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
    @EnvironmentObject var databaseConnection: DatabaseConnection
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
                ProfileView()
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
    @EnvironmentObject var databaseConnection: DatabaseConnection
    
    var body: some View {
        NavigationStack(path: $mainStack){
            TabView{
                Text("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                ProfileView()
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



