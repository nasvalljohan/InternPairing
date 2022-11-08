import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var um: UserManager
    @EnvironmentObject var cm: ConversationsManager
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("tertiaryColor").ignoresSafeArea()
            
            if let contacts = um.contactsArray {
                
                
                VStack (alignment: .leading){
                    //TODO: Messaging
                    ZStack {
                        HStack {
                            Text("MESSAGES")
                                .font(.title)
//                                .fontWeight(.light)
                                .foregroundColor(Color("secondaryColor"))
                            
                            Spacer()
                        }
                        .padding(.horizontal)
//                        .padding(.bottom)
                        .background(Color("primaryColor"))
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("primaryColor"))
                    
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 5) {
                            ForEach(contacts, id: \.self) {
                                user in
                                
                                    NavigationLink(destination: {
                                        ChatRoomView().navigationBarBackButtonHidden(true)
                                    }, label: {
                                        ChatCards(user: user)
                                    })
                                
                                
                            }
                        }
                    }.padding(.horizontal)
                    
                }
            }
        }
    }
}

struct ChatCards: View {
    @EnvironmentObject var um: UserManager
    var user: TheUser
    
    var body: some View {
        
        HStack {
            AsyncImage(url: URL(string: user.imageUrl ?? "profile-placeholder"), content: {
                pic in
                pic
                    .resizable()
                    .scaledToFill()
            }, placeholder: {
                Image("profile-placeholder")
                    .resizable()
                    .scaledToFill()
                
            }).frame(width: 70, height: 70).clipShape(Circle())
            
            if um.theUser.role == "Recruiter" {
                VStack (alignment: .leading){
                    
                    Text(user.firstName ?? "").font(.subheadline)
                        .foregroundColor(Color("primaryColor"))
                        .fontWeight(.semibold)
                    Text("latestMessagePreview").font(.subheadline)
                        .foregroundColor(Color(.black))
                        .fontWeight(.ultraLight)
                }
            }
            
            if um.theUser.role == "Intern" {
                VStack (alignment: .leading){
                    HStack {
                        Text(user.firstName ?? "").font(.subheadline)
                            .foregroundColor(Color("primaryColor"))
                            .fontWeight(.semibold)
                        Text(user.companyName ?? "").font(.caption2).fontWeight(.ultraLight)
                    }
                    Text("latestMessagePreview").font(.subheadline)
                        .foregroundColor(Color(.black))
                        .fontWeight(.ultraLight)
                }
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    
    static var previews: some View {
                ContactsView()
    }
}
