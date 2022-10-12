import SwiftUI

struct SwipeView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        //SwipeViewStudent()
        SwipeViewRecruiter()
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}

enum NavigationType: String, Hashable {
    case swipe = "SWIPE VIEW"
    case contact = "CONTACT VIEW"
    case profile = "PROFILE VIEW"
}


struct SwipeViewRecruiter: View {
    @State var mainStack: [NavigationType] = []
    
    var body: some View {
        NavigationStack(path: $mainStack){
            TabView{
                Text("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                Text("Swipe")
                    .tabItem{
                        Image(systemName: "suit.heart.fill")
                    }
                    .onTapGesture{
                        mainStack.append(.swipe)
                    }
                Text("Profile")
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
            .navigationDestination(for: NavigationType.self) { value in
                switch(value){
                case .swipe: SignUpView()
                case .contact: Text("Contact view")
                case .profile: Text("Profile view!! ")
                }
            }
        }
    }
}

struct SwipeViewStudent: View {
    @State var mainStack: [NavigationType] = []
    
    var body: some View {
        NavigationStack(path: $mainStack){
            TabView{
                Text("Home").tabItem {
                    Image(systemName: "house.fill")
                }
                Text("Profile").tabItem{
                    Image(systemName: "person.circle")
                }
                Text("Contacts").tabItem{
                    Image(systemName: "message.fill")
                }
            }
            .navigationTitle("Jinder")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


