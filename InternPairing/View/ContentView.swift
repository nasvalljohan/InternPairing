import SwiftUI

struct ContentView: View {
    @State private var isUserLoggedIn = false
    var body: some View {
        
        
        if isUserLoggedIn{
            // Go somewhere
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
