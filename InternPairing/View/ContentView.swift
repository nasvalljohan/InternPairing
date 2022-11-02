import SwiftUI
import FirebaseAuth

// MARK: ContentView
struct ContentView: View {
    
    @StateObject var photoViewModel = PhotoPicker()
    @StateObject var db = DataManager()
    
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

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
   
    static var previews: some View {
        ContentView(photoViewModel: PhotoPicker())
    }
}


