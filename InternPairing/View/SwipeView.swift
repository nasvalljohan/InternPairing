import SwiftUI

// MARK: SwipeView
struct SwipeView: View {
    @EnvironmentObject var db: DataManager

    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                ZStack{
                    
                    ForEach(db.fetchedArray, id: \.self) { user in

                        CardView(user: user, onRemove: { removedUser in
//                            Remove that user from our array
                            db.fetchedArray.removeAll { $0.id == removedUser.id }
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

                VStack(alignment: .center) {
                    if user.imageUrl != "" || user.imageUrl != nil {
                        AsyncImage(url: URL(string: user.imageUrl ?? ""), content: {
                            pic in
                            pic.resizable()
                        }, placeholder: {
                            Image("profile-placeholder")
                                .frame(width: geometry.size.width * 0.9,
                                       height: geometry.size.height * 0.75) // 3
                                .clipped()
                                .scaledToFit()
                        }).frame(width: geometry.size.width * 0.9,
                                 height: geometry.size.height * 0.75) // 3
                            .clipped()
                            .scaledToFit()
                    } else {
                        Text("Hallå")
                        Image("profile-placeholder")
                            .frame(width: geometry.size.width * 0.9,
                                   height: geometry.size.height * 0.75) // 3
                            .clipped()
                            .scaledToFit()
                    }

                    
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
        
        CardView(user: TheUser(role: "Intern", location: "Stockholm", imageUrl: "..", firstName: "Johan", dateOfBirth: Date()), onRemove: {
            removedUser in
        })
        
    }
}
