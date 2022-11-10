import SwiftUI
import FirebaseAuth

//Global var 
var formatter = Formatter()

// MARK: ContentView
struct ContentView: View {
    
    @StateObject var photoViewModel = PhotoPicker()
    @StateObject var db = DataManager()
    @StateObject var storageManager = StorageManager()
    @State var mainStack: [NavigationType] = []
    
    var body: some View {
        
        VStack {
            
            if db.userLoggedIn {
                NavigationStack(path: $mainStack){
                    TabView{
                        ProfileView()
                            .tabItem{
                                Image(systemName: "person.circle")
                            }
                        if db.theUser?.role == "Recruiter" {
                            SwipeView()
                                .tabItem {
                                    Image(systemName: "suit.heart.fill")
                                }
                        }
                        ContactsView()
                            .tabItem{
                                Image(systemName: "message.fill")
                            }
                    }.accentColor(Color("primaryColor"))
                    
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

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
   
    static var previews: some View {
        ContentView()
    }
}
