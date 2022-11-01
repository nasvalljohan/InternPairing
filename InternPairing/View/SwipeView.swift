import SwiftUI

// MARK: SwipeView
struct SwipeView: View {
    @EnvironmentObject var db: DataManager
    @State private var showingSheet: Bool = false
    @State var currentIntern: TheUser?
    
    func pickCurrentIntern(intern: TheUser){
        currentIntern = intern
    }

    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                ZStack{
                    
                    ForEach(db.fetchedArray, id: \.self) { user in
                        
                        CardView(user: user, onRemove: { removedUser in
                            // Remove that user from our array
                            db.fetchedArray.removeAll { $0.id == removedUser.id }
                          })
                        .onTapGesture {
                            showingSheet.toggle()
                            pickCurrentIntern(intern: user)
                        }
                        .animation(.spring(), value: 10)
                    }
                }.sheet(isPresented: $showingSheet) {
                    PopUpCardView(showingSheet: $showingSheet, currentIntern: $currentIntern)
                    
                }
                
            }

        }
    }
}

// MARK: CardView
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
                
                VStack {
                    ZStack (alignment: .bottomLeading) {
                        
                        AsyncImage(url: URL(string: user.imageUrl ?? ""), content: {
                            pic in
                            pic
                                .resizable()
                                .scaledToFill()
                        }, placeholder: {
                            Image("profile-placeholder")
                                .resizable()
                                .scaledToFill()
                            
                        }).frame(width: geometry.size.width * 0.8,
                                 height: geometry.size.height * 0.8)
                        
                        VStack (alignment: .leading){
                            VStack(alignment: .leading, spacing: 6) {
                                Text("\(user.firstName ?? "not specified"), 29")
                                    .font(.title)
                                    .bold()
                                Text("Frontend Android Developer")
                                    .font(.subheadline)
                                    .bold()
                            }
                            HStack {
                                Text("\(user.location ?? "not specified")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Image(systemName: "info.circle")
                                    .foregroundColor(.gray)
                            }
                        }.padding(5)
                    }.padding(.horizontal)
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding(.bottom)
                .padding(.top)
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
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            
        }
    }
}



struct PopUpCardView: View {
    @EnvironmentObject var db: DataManager
    @Binding var showingSheet: Bool
    @Binding var currentIntern: TheUser?
    
    var body: some View {
        if let currentIntern = currentIntern{

            ZStack {
                Button(action: {
                    showingSheet.toggle()
                    db.pushLikedIntern(intern: currentIntern.id ?? "0")
                }, label: {
                    Text("I like this one..")
                        .padding()
                        .frame(width: 300)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
            }
        }
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
