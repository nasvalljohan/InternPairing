import SwiftUI

// MARK: ProfileView
struct ProfileView: View {
    var body: some View {
        VStack{
            Text("This is the profileView")
        }.background(.black).foregroundColor(.white)
    }
}

// MARK: Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

