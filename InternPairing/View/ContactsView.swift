
import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var db: DataManager
    var userList = ["Erik", "Jonas", "Peter", "Adam", "Oskar", "1"]
    
    var body: some View {
        VStack {
            ZStack {
                Color("tertiaryColor").ignoresSafeArea()
                VStack (alignment: .leading){
                    
                    Text("NEW MATCHES").font(.title2)
                        .foregroundColor(Color("primaryColor"))
                        .bold()
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(userList, id: \.self) { user in
                                MatchesCard()
                            }.clipped()
                        }
                    }
                    Text("MESSAGES").font(.title2)
                        .foregroundColor(Color("primaryColor"))
                        .bold()
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 5) {
                            ForEach(userList, id: \.self) {
                                user in
                                ChatCards()
                                
                            }
                        }
                    }
                    
                }.padding(.horizontal)
            }
        }
    }
}


struct MatchesCard: View {
    @EnvironmentObject var db: DataManager
    var body: some View {
        
        ZStack (alignment: .bottomLeading) {
            AsyncImage(url: URL(string: "https://t3.ftcdn.net/jpg/01/71/25/36/360_F_171253635_8svqUJc0BnLUtrUOP5yOMEwFwA8SZayX.jpg"), content: {
                pic in
                pic
                    .resizable()
                    .scaledToFill()
            }, placeholder: {
                Image("profile-placeholder")
                    .resizable()
                    .scaledToFill()
                
            }).overlay(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.01), Color.black]), startPoint: .center, endPoint: .bottom)).frame(width: 100, height: 135).clipped().cornerRadius(5)
            
            VStack (alignment: .center) {
                Text("FirstName")
                    .font(.subheadline)
                    .foregroundColor(Color("tertiaryColor"))
                    .bold()
                
                if db.theUser?.role == "Intern" {
                    VStack {
                        Text("Mobile interaction ").font(.caption).fontWeight(.light).foregroundColor(Color(.white)).frame(maxWidth: 100).fixedSize(horizontal: true, vertical: false).lineLimit(2)
                    }.clipped()
                }
            }.offset(y: -2).frame(maxWidth: 100)
        }
    }
}

struct ChatCards: View {
    @EnvironmentObject var db: DataManager
    var body: some View {
        
        HStack {
            AsyncImage(url: URL(string: "https://t3.ftcdn.net/jpg/01/71/25/36/360_F_171253635_8svqUJc0BnLUtrUOP5yOMEwFwA8SZayX.jpg"), content: {
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
                    
                    Text("FirstName").font(.subheadline)
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
                        Text("FirstName").font(.subheadline)
                            .foregroundColor(Color("primaryColor"))
                            .fontWeight(.semibold)
                        Text("CompanyName").font(.caption2).fontWeight(.ultraLight)
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
