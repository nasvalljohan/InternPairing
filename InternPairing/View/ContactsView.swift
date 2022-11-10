import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var db: DataManager
    @State var currentDocID = ""
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("tertiaryColor").ignoresSafeArea()
            
            if let conversations = db.conversationsArray,
               let contacts = db.contactsArray {

                VStack (alignment: .leading, spacing: 0){
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
                        .padding(.bottom)
                        .background(Color("primaryColor"))
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("primaryColor"))
                    
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 5) {
                            ForEach(contacts, id: \.self) {
                                user in
                                
                                
                                NavigationLink(destination: {
                                    ChatRoomView(currentDocID: $currentDocID, chatPerson: user)
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    ChatCards(user: user)
                                }).simultaneousGesture(TapGesture().onEnded {
                                    for conversation in conversations {
                                        if conversation.members.contains(user.id ?? "") {
                                            db.messages = conversation.messages
                                            print(db.messages)
                                            currentDocID = conversation.id ?? ""
                                        }
                                    }
                                })
                            }
                        }.padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct ChatCards: View {
    @EnvironmentObject var db: DataManager
    var user: TheUser

    var body: some View {

        HStack {
            AsyncImage(url: URL(string: user.imageUrl ?? ""), content: {
                pic in
                pic
                    .resizable()
                    .scaledToFill()
            }, placeholder: {
                Image("profile-placeholder")
                    .resizable()
                    .scaledToFill()

            }).frame(width: 70, height: 70).clipShape(Circle())

            if db.theUser?.role == "Recruiter" {
                VStack (alignment: .leading){

                    Text(user.firstName ?? "").font(.subheadline)
                        .foregroundColor(Color("primaryColor"))
                        .fontWeight(.semibold)
                    Text("latestMessagePreview").font(.subheadline)
                        .foregroundColor(Color(.black))
                        .fontWeight(.ultraLight)
                }
            }

            if db.theUser?.role == "Intern" {
                VStack (alignment: .leading){
                    HStack {
                        Text(user.firstName ?? "" ).font(.subheadline)
                            .foregroundColor(Color("primaryColor"))
                            .fontWeight(.semibold)
                        Text(user.lastName ?? "" ).font(.caption2).fontWeight(.ultraLight)
                    }
                    Text("latestMessagePreview").font(.subheadline)
                        .foregroundColor(Color(.black))
                        .fontWeight(.ultraLight)
                }
            }
        }.padding(.top)
    }
}
//
//struct ContactsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//                ContactsView()
//    }
//}
