import SwiftUI
import FirebaseAuth

// MARK: ContentView
struct ContentView: View {
    
    @StateObject var photoViewModel = PhotoPicker()
    @StateObject var db = DataManager()
    @StateObject var storageManager = StorageManager()
    var body: some View {
        
        VStack {
            if db.userLoggedIn {
                if db.theUser?.role == "Recruiter" {
                    if db.theUser?.isUserComplete == false{
                        UserDetailsView()
                    }else {
                        TabViewRecruiter()
                    }
                    
                } else if db.theUser?.role == "Intern" {
                    if db.theUser?.isUserComplete == false {
                        UserDetailsView()
                    } else {
                        TabViewStudent()
                    }
                    
                }
            } else{
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
                SwipeView()
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                Text("Contacts").tabItem{
                    //Contacts view here
                    Image(systemName: "message.fill")
                }
                ProfileView()
                    .tabItem{
                    Image(systemName: "person.circle")
                }
                
            }
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
                Text("Contacts")
                //Contacts view here
                    .tabItem{
                        Image(systemName: "message.fill")
                    }
            }

        }
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
   
    static var previews: some View {
        ContentView()
    }
}


