
import SwiftUI
import PhotosUI

struct EditProfileView: View {
    // TODO: make rules for going to next page
    @EnvironmentObject var db: DataManager
    var body: some View {
        ZStack {
            
            if db.theUser?.role == "Recruiter" {
                EditRecruiterProfileView()
            } else if db.theUser?.role == "Intern" {
                EditInternProfileView()
            }
        }
    }
}

// MARK: Recruiter view
struct EditRecruiterProfileView: View {
    // navigate back
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var db: DataManager
    @EnvironmentObject var photoViewModel: PhotoPicker
    @EnvironmentObject var storageManager: StorageManager
    @State var description = ""
    @State var linkedIn = ""
    @State var location = ""
    @State var companyLink = ""
    @State var typeOfDeveloper = 1
    @State var imageUrl = ""
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("tertiaryColor").ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 50)
                .fill(Color("primaryColor"))
                .ignoresSafeArea()
                .offset(y: -100)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .shadow(radius: 4, x: 2, y: 2)
            
            VStack {
                
                Spacer()
                
                ZStack {
                    Color("secondaryColor")
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Text("Add details").font(.title3).fontWeight(.light)
                            Spacer()
                            VStack(alignment: .leading) {
                                
                                Text(" Description").font(.subheadline).fontWeight(.light).offset(y: 10)
                                TextField("", text: $description, axis: .vertical)
                                    .onChange(of: description, perform: { value in
                                        description=String(description.prefix(200))
                                    })
                                    .lineLimit(2...4)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                
                                Text(" LinkedIn").font(.subheadline).fontWeight(.light).offset(y: 10)
                                TextField("", text: $linkedIn)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                
                                Text(" Website").font(.subheadline).fontWeight(.light).offset(y: 10)
                                TextField("", text: $companyLink)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                
                                Text(" Location").font(.subheadline).fontWeight(.light).offset(y: 10)
                                TextField("", text: $location)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                            
                            VStack {
                                GeometryReader { geometry in
                                    
                                    HStack(spacing: 0) {
                                        Text(" Looking for").font(.subheadline).fontWeight(.light)
                                        Spacer()
                                        Picker(
                                            selection: $typeOfDeveloper, label: Text("Looking for")) {
                                                Text("Android").tag(1)
                                                Text("iOS").tag(2)
                                                Text("Hybrid").tag(3)
                                            }
                                            .pickerStyle(.segmented)
                                            .compositingGroup()
                                    }
                                }
                            }.padding(.vertical)
                            Spacer()
                        }.padding(25)
                    }
                    .shadow(radius: 0.1, x: 0.3, y: 0.3)
                }
                .background(Color("secondaryColor"))
                .cornerRadius(30)
                .shadow(radius: 4, x: 2, y: 2)
                .frame(
                    width: UIScreen.main.bounds.width * 0.9,
                    height: UIScreen.main.bounds.height * 0.5
                )
                
                Spacer()
                
                Button(action: {
                    db.pushUserDetails(
                        description: description,
                        linkedInLink: linkedIn,
                        otherLink: "",
                        location: location,
                        githubLink: "",
                        typeOfDeveloper: typeOfDeveloper,
                        companyLink: companyLink
                    )
                }, label: {
                    Text("Save")
                        .padding()
                        .frame(width: 250)
                        .background(Color("primaryColor"))
                        .foregroundColor(Color("secondaryColor"))
                        .cornerRadius(10)
                }).shadow(radius: 4, x: 2, y: 2)
                
                Spacer()
            }
        }
        
    }
}


//MARK: Intern View
struct EditInternProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var db: DataManager
    @EnvironmentObject var photoViewModel: PhotoPicker
    @EnvironmentObject var storageManager: StorageManager
    
    @State var description = ""
    @State var linkedIn = ""
    @State var location = ""
    @State var github = ""
    @State var typeOfDeveloper = 1
    @State var imageUrl = ""
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("tertiaryColor").ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 50)
                .fill(Color("primaryColor"))
                .ignoresSafeArea()
                .offset(y: -100)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .shadow(radius: 4, x: 2, y: 2)
            
            VStack {
                
                Spacer()
                
                ZStack {
                    Color("secondaryColor")
                    ScrollView(showsIndicators: false){
                        VStack {
                            Text("Add details").font(.title3).fontWeight(.light)
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Description").font(.subheadline).fontWeight(.light).offset(y: 10)
                                TextField("", text: $description, axis: .vertical)
                                    .onChange(of: description, perform: { value in
                                        description=String(description.prefix(200))
                                    })
                                    .lineLimit(2...4)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                
                                Text("LinkedIn").font(.subheadline).fontWeight(.light).offset(y: 10)
                                TextField("", text: $linkedIn)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                
                                Text("Github").font(.subheadline).fontWeight(.light).offset(y: 10)
                                TextField("", text: $github)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                
                                Text("Location").font(.subheadline).fontWeight(.light).offset(y: 10)
                                TextField("", text: $location)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                            
                            VStack {
                                GeometryReader { geometry in
                                    
                                    HStack(spacing: 0) {
                                        Text("Orientation").font(.subheadline).fontWeight(.light)
                                        Spacer()
                                        Picker(
                                            selection: $typeOfDeveloper, label: Text("I am")) {
                                                Text("Android").tag(1)
                                                Text("iOS").tag(2)
                                                Text("Hybrid").tag(3)
                                            }
                                            .pickerStyle(.segmented)
                                            .compositingGroup()
                                            .backgroundStyle(Color("tertiaryColor"))
//                                            .foregroundColor(Color(.lightGray))
                                    }
                                }
                            }.padding(.vertical)
                            
                            Spacer()
                        }.padding(25)
                    }.shadow(radius: 0.1, x: 0.3, y: 0.3)
                }
                .background(Color("secondaryColor"))
                .cornerRadius(30)
                .shadow(radius: 4, x: 2, y: 2)
                .frame(
                    width: UIScreen.main.bounds.width * 0.9,
                    height: UIScreen.main.bounds.height * 0.5
                )
                
                Spacer()
                
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text(Image(systemName: "arrow.uturn.backward"))
                            .padding()
                            .frame(width: 60)
                            .background(Color("primaryColor"))
                            .foregroundColor(Color("secondaryColor"))
                            .cornerRadius(10)
                    }).shadow(radius: 4, x: 2, y: 2)
                    HStack {
                        Button(action: {
                            db.pushUserDetails(
                                description: description,
                                linkedInLink: linkedIn,
                                otherLink: "",
                                location: location,
                                githubLink: github,
                                typeOfDeveloper: typeOfDeveloper,
                                companyLink: ""
                            )
                        }, label: {
                            Text("Save")
                                .padding()
                                .frame(width: 250)
                                .background(Color("primaryColor"))
                                .foregroundColor(Color("secondaryColor"))
                                .cornerRadius(10)
                        }).shadow(radius: 4, x: 2, y: 2)
                    }
                }
                Spacer()
            }
        }
    }
}
//struct UserDetailsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
////        InternDetailsView()
//        RecruiterDetailsView()
//    }
//}
