import SwiftUI

// MARK: SwipeView
struct SwipeView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {

        VStack {
            Text("THIS IS WHERE THE SWIPE VIEW GOES")
        }
    }
}

// MARK: Preview
struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}



