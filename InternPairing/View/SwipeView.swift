import SwiftUI

// MARK: SwipeView
struct SwipeView: View {
    @EnvironmentObject var databaseConnection: DatabaseConnection
    var body: some View {
        VStack {
            
            Button(action: {
                databaseConnection.fetchSwipeableStudents()
                
            }, label: {
                Text("Fetch swipeable students")
            })
        }
    }
}

// MARK: Preview
struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}






