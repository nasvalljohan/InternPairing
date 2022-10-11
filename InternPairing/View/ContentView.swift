import SwiftUI

struct ContentView: View {
    @StateObject var dataManager = DataManager()
    @State private var isUserLoggedIn = false
    var body: some View {
        
        
        if isUserLoggedIn{
            SwipeView()
                .environmentObject(dataManager)
        } else{
            LoginView(isUserLoggedIn: $isUserLoggedIn)
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
