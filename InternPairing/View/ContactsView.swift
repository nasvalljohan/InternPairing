import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var db: DataManager
    
    var body: some View {
        ZStack {
            Color("tertiaryColor").ignoresSafeArea()
            if let contacts = db.contactsArray {
                
                VStack (alignment: .leading){
                    //TODO: Messaging
                    Text("MESSAGES").font(.title2)
                        .foregroundColor(Color("primaryColor"))
                        .bold()
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 5) {
                            ForEach(contacts, id: \.self) {
                                user in
                                ChatCards(user: user)
                            }.onTapGesture {
                                
                            }
                        }
                    }
                    
                }.padding(.horizontal).padding(.top)
            }
        }
    }
}

struct ChatCards: View {
    @EnvironmentObject var db: DataManager
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
