import SwiftUI
import FirebaseAuth

//Global singleton
var dm = DataManager()

// MARK: ContentView
struct ContentView: View {
    @StateObject var um = UserManager()
    @StateObject var cm = ConversationsManager()
    @StateObject var photoViewModel = PhotoPicker()
    @StateObject var storageManager = StorageManager()
    var body: some View {
        
        VStack {
            if um.userLoggedIn {
                if um.theUser.role == "Recruiter" {
                    TabViewRecruiter()
                } else if um.theUser.role == "Intern" {
                    TabViewStudent()
                }
            } else{
                LoginView()
            }
        }
        .environmentObject(um)
        .environmentObject(cm)
        .environmentObject(photoViewModel)
        .environmentObject(storageManager)
    }
}


enum NavigationType: String, Hashable {
    case swipe = "SWIPE VIEW"
    case contact = "CONTACT VIEW"
    case profile = "PROFILE VIEW"
}

// MARK: TabViewRecruiter
struct TabViewRecruiter: View {
    @EnvironmentObject var um: UserManager
    @State var mainStack: [NavigationType] = []

    var body: some View {
        NavigationStack(path: $mainStack){
            TabView{
                ProfileView()
                    .tabItem{
                    Image(systemName: "person.circle")
                }
                SwipeView()
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                ContactsView()
                    .tabItem{
                    Image(systemName: "message.fill")
                }
            }.accentColor(Color("primaryColor"))
            
        }
    }
}

// MARK: TabViewStudent
struct TabViewStudent: View {
    @EnvironmentObject var um: UserManager
    @State var mainStack: [NavigationType] = []
    
    
    var body: some View {
        NavigationStack(path: $mainStack){
            TabView{
                ProfileView()
                    .tabItem{
                        Image(systemName: "person.circle")
                    }
                ContactsView()
                    .tabItem{
                        Image(systemName: "message.fill")
                    }
            }.accentColor(Color("primaryColor"))

        }
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
   
    static var previews: some View {
        ContentView()
    }
}


