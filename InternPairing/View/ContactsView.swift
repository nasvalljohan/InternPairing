import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var db: DataManager
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("tertiaryColor").ignoresSafeArea()
            
            if let conversations = db.conversationsArray {

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
                            ForEach(conversations, id: \.self) {
                                conversation in

                                NavigationLink(destination: {
                                    ChatRoomView( messages: conversation.messages, internFirstName: conversation.internFirstname, internLastName: conversation.internLastname, recruiterFirstName: conversation.recruiterFirstname, recruiterLastName: conversation.recruiterLastname, internImage: conversation.internImage, recruiterImage: conversation.recruiterImage)
                                    
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    ChatCards(conversation: conversation)
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
    @EnvironmentObject var db: DataManager
    var conversation: Conversation

    var body: some View {

        HStack {
            AsyncImage(url: URL(string: db.theUser?.role == "Intern" ? conversation.recruiterImage : conversation.internImage ), content: {
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

                    Text(conversation.internFirstname ).font(.subheadline)
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
                        Text(conversation.recruiterFirstname ).font(.subheadline)
                            .foregroundColor(Color("primaryColor"))
                            .fontWeight(.semibold)
                        Text(conversation.recruiterLastname ).font(.caption2).fontWeight(.ultraLight)
                    }
                    Text("latestMessagePreview").font(.subheadline)
                        .foregroundColor(Color(.black))
                        .fontWeight(.ultraLight)
                }
            }
        }.padding(.top)
    }
}

struct ContactsView_Previews: PreviewProvider {
    
    static var previews: some View {
                ContactsView()
    }
}
