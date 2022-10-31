import SwiftUI

// MARK: ProfileView
struct ProfileView: View {
    @EnvironmentObject var db: DataManager
    var body: some View {
        VStack{
            if db.theUser?.role == "Recruiter" {
                RecruiterProfileView()
            } else if db.theUser?.role == "Intern" {
                StudentProfileView()
            }
        }
    }
}

// MARK: Preview
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentProfileView().environmentObject(DatabaseConnection())
//    }
//}

// MARK: RecruiterProfileView
struct RecruiterProfileView: View {
    @EnvironmentObject var db: DataManager
    var typeOf = TypeOf()
    
    var body: some View {
        ZStack {
            if let companyName = db.theUser?.companyName,
               let description = db.theUser?.description {
                let typeOfPosition = typeOf.typeOfPos(int: db.theUser?.typeOfPosition ?? 0)
                let typeOfDeveloper = typeOf.typeOfDev(int: db.theUser?.typeOfDeveloper ?? 0)
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
}

// MARK: StudentProfileView
struct StudentProfileView: View {
    @EnvironmentObject var db: DataManager
    var typeOf = TypeOf()
    
    var body: some View {
        ZStack {
            if let firstName = db.theUser?.firstName,
               let lastName = db.theUser?.lastName,
               let dateOfBirth = db.theUser?.dateOfBirth,
               let location = db.theUser?.location,
               let description = db.theUser?.description {
                let typeOfPosition = typeOf.typeOfPos(int: db.theUser?.typeOfPosition ?? 0)
                let typeOfDeveloper = typeOf.typeOfDev(int: db.theUser?.typeOfDeveloper ?? 0)
                VStack {
                    
                    VStack {
                        AsyncImage(
                            url: URL(string: db.theUser?.imageUrl ?? ""),
                            content: { image in
                                
                                image.resizable()
                                
                        }, placeholder: {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 250, height: 250)
                                .border(.black)
                        })
                        .frame(width: UIScreen.main.bounds.width, height: 250)
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
}

struct TypeOf {
    func typeOfDev(int: Int) -> String {
        var str = ""
        
        switch int {
        case 1: str = "Android"
        case 2: str = "iOS"
        case 3: str = "React Native"
        default: str = "Not specified"
        }
        
        return str
    }
    
    func typeOfPos(int: Int) -> String {
        var str = ""
        
        switch int {
        case 1: str = "Backend"
        case 2: str = "Frontend"
        case 3: str = "Fullstack"
        default: str = "Not specified"
        }
        
        return str
    }
}
