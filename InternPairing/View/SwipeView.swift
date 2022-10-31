import SwiftUI

// MARK: SwipeView
struct SwipeView: View {
    @EnvironmentObject var databaseConnection: DataManager

    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                ZStack{
                    
                    ForEach(databaseConnection.fetchedArray, id: \.self) { user in

                        CardView(user: user, onRemove: { removedUser in
//                            Remove that user from our array
                            databaseConnection.fetchedArray.removeAll { $0.id == removedUser.id }
                          })
                        .animation(.spring(), value: 10)

                    }
                }
            }
        }
    }
}

struct CardView: View {
    @State private var translation: CGSize = .zero
    private var user: TheUser
    private var onRemove: (_ user: TheUser) -> Void
    private var thresholdPercentage: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
   
    
    init(user: TheUser, onRemove: @escaping (_ user: TheUser) -> Void){
        self.user = user
        self.onRemove = onRemove
    }
    

    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    
    var body: some View {
        VStack{
            GeometryReader { geometry in

                VStack(alignment: .leading) {
                    
                    AsyncImage(url: URL(string: "https://media.istockphoto.com/vectors/man-silhouette-profile-picture-vector-id526947869?k=20&m=526947869&s=612x612&w=0&h=j528SMpxB1AOCNs-WUcuQjvNRVuO-0PO1djfq-Rq6dE="), content: {
                        pic in
                        pic.resizable()
                    }, placeholder: {
                        Text("Loading...")
                    }).frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.75) // 3
                        .clipped()
                        .scaledToFit()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(user.firstName ?? "not specified"), \(user.dateOfBirth ?? Date())")
                                .font(.title)
                                .bold()
                            Text("\(user.role ?? "not specified")")
                                .font(.subheadline)
                                .bold()
                            Text("\(user.location ?? "not specified")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                    }.padding(.horizontal)
                }
                .padding(.bottom)
                .padding(.top)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .offset(x: self.translation.width, y: self.translation.height/4)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.translation = value.translation
                        }.onEnded { value in
                            if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                                self.onRemove(self.user)
                            } else {
                                self.translation = .zero
                            }
                        }
                )
            }
        }
    }
}

struct EnlargedCardView: View {
    var body: some View {
        
        Text("Tjena")
    }
}

// MARK: Preview
struct SwipeView_Previews: PreviewProvider {
 
    static var previews: some View {
        
        CardView(user: TheUser(role: "Intern", location: "Stockholm", firstName: "Johan", dateOfBirth: Date()), onRemove: {
            removedUser in
        })
        
    }
}
