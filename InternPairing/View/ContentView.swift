import SwiftUI
import FirebaseAuth

//Global var 
var formatter = Formatter()

// MARK: ContentView
struct ContentView: View {
    
    @StateObject var photoViewModel = PhotoPicker()
    @StateObject var db = DataManager()
    @StateObject var storageManager = StorageManager()
    var body: some View {
        
        VStack {
            
            if db.userLoggedIn {
                if db.theUser?.role == "Recruiter" {
                    TabViewRecruiter()
                }
                if db.theUser?.role == "Intern" {
                    TabViewStudent()
                }
            }
            if !db.userLoggedIn{
                LoginView()
            }
        }
        .environmentObject(db)
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
    @EnvironmentObject var db: DataManager
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
    @EnvironmentObject var db: DataManager
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


