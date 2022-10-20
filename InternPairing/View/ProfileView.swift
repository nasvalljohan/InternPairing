import SwiftUI

// MARK: ProfileView
struct ProfileView: View {
    @ObservedObject var databaseConnection: DatabaseConnection
    var body: some View {
        VStack{
            if databaseConnection.userRecruiter?.role == "recruiter" {
                RecruiterProfileView()
            } else if databaseConnection.userIntern?.role == "student" {
                    StudentProfileView()
                }
            
            
        }
    }
}

// MARK: Preview
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

struct RecruiterProfileView: View {
    var companyName = "Apple"
    var description = "We make computers and produce apples, we like cake and we also like to play basketball with our daddies"
    var linkedInLink = "https://linkedin.com"
    var companyLink = "https://apple.com"
    var location = "Stockholm"
    var typeOfDeveloper =  "Android"
    var typeOfPosition = "Frontend"
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .border(.black)
                    Text("\(companyName)").font(.title3).bold()
                    Text("\(typeOfPosition) \(typeOfDeveloper)  developer").font(.subheadline).bold()
                    HStack {
                        Image(systemName: "square").resizable().frame(width: 20, height: 20)
                        Image(systemName: "square").resizable().frame(width: 20, height: 20)
                    }.font(.footnote)
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("\(description)")
                    }.padding()
                }
                Spacer()
                Button(action: {
                    print("hello")
                }, label: {
                    Text("Edit profile")
                        .frame(width: 150, height: 40)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
            }.padding()
            
        }
    }
}

struct StudentProfileView: View {
    
    var firstName = "Johan"
    var lastName = "Näsvall"
    var dateOfBirth = "29"
    var description = "Im studying my last year at Stockholm Tekniska institut as Android developer, im currently looking for internship starting in february. I am a hardworking little boy that loves to make friends and play in the mud hihi"
    var linkedInLink = "https://linkedin.com"
    var githubLink = "https://github.com"
    var otherLink = "google.se"
    var location = "Stockholm"
    var typeOfDeveloper =  "Android"
    var typeOfPosition = "Frontend"
    
    var body: some View {
        ZStack {
            VStack {
                
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .border(.black)
                    Text("\(firstName) \(lastName), \(dateOfBirth) \(location)").font(.title3).bold()
                    Text("\(typeOfPosition) \(typeOfDeveloper)  developer").font(.subheadline).bold()
                    HStack {
                        Image(systemName: "square").resizable().frame(width: 20, height: 20)
                        Image(systemName: "square").resizable().frame(width: 20, height: 20)
                        Image(systemName: "square").resizable().frame(width: 20, height: 20)
                    }.font(.footnote)
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("\(description)")
                    }.padding()
                }
                Spacer()
                Button(action: {
                    print("hello")
                }, label: {
                    Text("Edit profile")
                        .frame(width: 150, height: 40)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
            }.padding()
            
        }
    }
}

