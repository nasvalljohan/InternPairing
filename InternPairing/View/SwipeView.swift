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
                            
                        }).overlay(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.01), Color.black]), startPoint: .center, endPoint: .bottom))
                            .frame(width: geometry.size.width * 0.8,
                                 height: geometry.size.height * 0.9)
                        
                        VStack (alignment: .leading){
                            VStack(alignment: .leading, spacing: 6) {
                                Text("\(user.firstName ?? "not specified"), 29")
                                    .font(.title)
                                    .foregroundColor(Color("tertiaryColor"))
                                    .bold()
                                Text("Frontend Android Developer")
                                    .font(.subheadline)
                                    .foregroundColor(Color("tertiaryColor"))
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
                Rectangle().fill(Color("tertiaryColor")).ignoresSafeArea()
            
                VStack {
                    Spacer()
                    HStack {
                        ZStack {
                            Rectangle().fill(Color("primaryColor")).frame(width: 60, height: 326).cornerRadius(10)
                            Text("Portfolio").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 20, height: 180)
                        }.offset(x: -10)
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: currentIntern.imageUrl ?? ""), content: {
                            pic in
                            pic
                                .resizable()
                                .scaledToFill()
                        }, placeholder: {
                            Image("profile-placeholder")
                                .resizable()
                                .scaledToFill()
                        }).frame(width: 220, height: 360)
                            .cornerRadius(20)
                            .clipped()
                        
                        Spacer()
                        ZStack {
                            Rectangle().fill(Color("primaryColor")).frame(width: 60, height: 326).cornerRadius(10)
                            Text("Resume").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 20, height: 180)
                        }.offset(x: 10)
                    }
                    VStack {
                        
                            Text("\(currentIntern.firstName ?? "") \(currentIntern.lastName ?? "")").font(.title).bold()
                            Text("Android Developer").font(.title3).fontWeight(.light)
                        
                        ScrollView {
                            Text(currentIntern.description ?? "Go add description!").font(.subheadline).fontWeight(.light).fixedSize(horizontal: false, vertical: true).padding()
                        }
                            
                        
                        
                        HStack (spacing: 0){
                            Image(systemName: "mappin").foregroundColor(.gray)
                            Text(currentIntern.location ?? "Location unknown").font(.subheadline).fontWeight(.light)
                        }
                        
                    }
                    Spacer()
                    
                    Button(action: {
                        showingSheet.toggle()
                        db.pushLikedIntern(intern: currentIntern.id ?? "0")
                    }, label: {
                        Text("Make contact")
                            .padding()
                            .frame(width: 300)
                            .background(Color("primaryColor"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }).padding()
                    Spacer()
                }
            }
        }
    }
}

// MARK: Preview
struct SwipeView_Previews: PreviewProvider {
 
    static var previews: some View {
        
//        CardView(user: TheUser(role: "Intern", location: "Stockholm", imageUrl: "..", firstName: "Johan", dateOfBirth: Date()), onRemove: {
//            removedUser in
//        })
        PopUpCardView(showingSheet: .constant(true), currentIntern: .constant(TheUser(id: "ID", isUserComplete: true, role: "Intern", description: "I am a student at STI and i want to be a good programmer and make loads of moneys :))", linkedInLink: "linkedin.com/janne", githubLink: "github.com/janne", otherLink: "facebook.com/janne", location: "Stockholm", typeOfDeveloper: 1, typeOfPosition: 1, imageUrl: "https://media-exp1.licdn.com/dms/image/C4E03AQEZZ2_wjw8flA/profile-displayphoto-shrink_800_800/0/1650979115801?e=2147483647&v=beta&t=xLL0WDLmZr9UNGoRRBZU6T6JAvAJrFGd9IwelBSpC1Y", firstName: "Johan", lastName: "Näsvall", dateOfBirth: Date(), gender: "Male")))
        
    }
}
