import SwiftUI

struct SwipeView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
//            List(dataManager.userInterns, id: \.id) { user in
//                Text(user.name)
//
//            }
//            .navigationTitle("UserInterns")
//            .navigationBarItems(trailing: Button(action: {
//                // add
//            }, label: {
//                Image(systemName: "plus")
//            }))
        }
        
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
