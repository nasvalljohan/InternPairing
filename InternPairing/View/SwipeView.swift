import SwiftUI

struct SwipeView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {

        VStack {
            Text("THIS IS WHERE THE SWIPE VIEW GOES")
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}



