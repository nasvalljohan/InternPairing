
import SwiftUI
import PhotosUI

struct EditProfileView: View {
    // TODO: make rules for going to next page
    @EnvironmentObject var db: DataManager
    var body: some View {
        ZStack {
            
            if db.theUser?.role == "Recruiter" {
                EditRecruiterProfileView(
                    firstName: db.theUser?.firstName ?? "",
                    lastName: db.theUser?.lastName ?? "",
                    companyName: db.theUser?.companyName ?? "",
                    description: db.theUser?.description ?? "",
                    linkedin: db.theUser?.linkedInLink ?? "https://www.linkedin.com/",
                    location: db.theUser?.location ?? "",
                    companyLink: db.theUser?.companyLink ?? "https://www.",
                    typeOfDeveloper: db.theUser?.typeOfDeveloper ?? 1
                ).navigationBarBackButtonHidden(true)
            } else if db.theUser?.role == "Intern" {
                EditInternProfileView(
                    firstName: db.theUser?.firstName ?? "",
                    lastName: db.theUser?.lastName ?? "",
                    description: db.theUser?.description ?? "",
                    linkedin: db.theUser?.linkedInLink ?? "https://www.linkedin.com/",
                    location: db.theUser?.location ?? "",
                    typeOfDeveloper: db.theUser?.typeOfDeveloper ?? 1,
                    github: db.theUser?.githubLink ?? "https://www.github.com/",
                    otherLink: db.theUser?.otherLink ?? ""
                ).navigationBarBackButtonHidden(true)
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
    
    var firstName: String
    @State var editedFirstName: String
    var lastName: String
    @State var editedLastName: String
    var companyName: String
    @State var editedCompanyName: String
    var description: String
    @State var editedDescription: String
    var linkedIn: String
    @State var editedLinkedIn: String
    var location: String
    @State var editedLocation: String
    var companyLink: String
    @State var editedCompanyLink: String
    var typeOfDeveloper: Int
    @State var editedTypeOfDeveloper: Int
    
    @State var imageUrl = ""
    
    
    init(firstName: String, lastName: String, companyName: String, description: String, linkedin: String, location: String, companyLink: String, typeOfDeveloper: Int) {
        self.firstName = firstName
        self._editedFirstName = State(wrappedValue: firstName)
        self.lastName = lastName
        self._editedLastName = State(wrappedValue: lastName)
        self.companyName = companyName
        self._editedCompanyName = State(wrappedValue: companyName)
        self.description = description
        self._editedDescription = State(wrappedValue: description)
        self.linkedIn = linkedin
        self._editedLinkedIn = State(wrappedValue: linkedin)
        self.location = location
        self._editedLocation = State(wrappedValue: location)
        self.companyLink = companyLink
        self._editedCompanyLink = State(wrappedValue: companyLink)
        self.typeOfDeveloper = typeOfDeveloper
        self._editedTypeOfDeveloper = State(wrappedValue: typeOfDeveloper)
    }
    
    var body: some View {
        
        ZStack {
            Color("tertiaryColor").ignoresSafeArea()
            
            VStack {
                
                VStack {
                    Text("Edit profile")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(Color("primaryColor"))
                    
                    Spacer()
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 3) {
                                Text(" Firstname").font(.subheadline).fontWeight(.light).offset(y: 10)
                                Text("*").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.light).offset(y: 10)
                            }
                            TextField("", text: $editedFirstName)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 3) {
                                Text(" Lastname").font(.subheadline).fontWeight(.light).offset(y: 10)
                                Text("*").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.light).offset(y: 10)
                            }
                            TextField("", text: $editedLastName)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 3) {
                                Text(" Company name").font(.subheadline).fontWeight(.light).offset(y: 10)
                                Text("*").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.light).offset(y: 10)
                            }
                            TextField("", text: $editedCompanyName)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 3) {
                                Text(" Description").font(.subheadline).fontWeight(.light).offset(y: 10)
                                Text("*").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.light).offset(y: 10)
                            }
                                
                            TextField("", text: $editedDescription, axis: .vertical)
                                .onChange(of: description, perform: { value in
                                    editedDescription=String(editedDescription.prefix(200))
                                })
                                .lineLimit(2...4)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(" LinkedIn").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedLinkedIn)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(" Website").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedCompanyLink)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 3) {
                                Text(" Location").font(.subheadline).fontWeight(.light).offset(y: 10)
                                Text("*").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.light).offset(y: 10)
                            }
                            TextField("", text: $editedLocation)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                            
                            HStack(spacing: 0) {
                                Text(" Looking for").font(.subheadline).fontWeight(.light)
                                Spacer()
                                Picker(
                                    selection: $editedTypeOfDeveloper, label: Text("Looking for")) {
                                        Text("Android").tag(1)
                                        Text("iOS").tag(2)
                                        Text("Hybrid").tag(3)
                                    }
                                    .pickerStyle(.segmented)
                                    .compositingGroup()
                            }.padding(.vertical)
                    }
                    
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
                        })
                        .shadow(radius: 4, x: 2, y: 2)
                        
                        Button(action: {
                            db.pushUserDetails(
                                firstName: editedFirstName,
                                lastName: editedLastName,
                                companyName: editedCompanyName,
                                description: editedDescription,
                                linkedInLink: editedLinkedIn,
                                otherLink: "",
                                location: editedLocation,
                                githubLink: "",
                                typeOfDeveloper: editedTypeOfDeveloper,
                                companyLink: editedCompanyLink
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
                }.padding(25)
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
    
    var firstName: String
    @State var editedFirstName: String
    var lastName: String
    @State var editedLastName: String
    var description: String
    @State var editedDescription: String
    var linkedIn: String
    @State var editedLinkedIn: String
    var location: String
    @State var editedLocation: String
    var typeOfDeveloper: Int
    @State var editedTypeOfDeveloper: Int
    var github: String
    @State var editedGithub: String
    var otherLink: String
    @State var editedOtherLink: String
    
    @State var imageUrl = ""
    
    init(firstName: String, lastName: String, description: String, linkedin: String, location: String, typeOfDeveloper: Int, github: String, otherLink: String) {
        self.firstName = firstName
        self._editedFirstName = State(wrappedValue: firstName)
        self.lastName = lastName
        self._editedLastName = State(wrappedValue: lastName)
        self.description = description
        self._editedDescription = State(wrappedValue: description)
        self.linkedIn = linkedin
        self._editedLinkedIn = State(wrappedValue: linkedin)
        self.location = location
        self._editedLocation = State(wrappedValue: location)
        self.typeOfDeveloper = typeOfDeveloper
        self._editedTypeOfDeveloper = State(wrappedValue: typeOfDeveloper)
        self.github = github
        self._editedGithub = State(wrappedValue: github)
        self.otherLink = otherLink
        self._editedOtherLink = State(wrappedValue: otherLink)
    }
    
    var body: some View {
        
        ZStack {
            Color("tertiaryColor").ignoresSafeArea()
            
            VStack {
                
                VStack {
                    Text("Edit profile")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(Color("primaryColor"))
                    
                    Spacer()
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .leading) {
                            
                            
                            Text(" Firstname").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedFirstName)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(" Lastname").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedLastName)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(" Description").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedDescription, axis: .vertical)
                                .onChange(of: description, perform: { value in
                                    editedDescription=String(editedDescription.prefix(200))
                                })
                                .lineLimit(2...4)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(" LinkedIn").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedLinkedIn)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(" Github").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedGithub)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(" Other link").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedOtherLink)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text(" Location").font(.subheadline).fontWeight(.light).offset(y: 10)
                            TextField("", text: $editedLocation)
                                .textFieldModifier(backgroundColor: Color("secondaryColor"),textColor: Color("primaryColor"))
                        }
                            
                            HStack(spacing: 0) {
                                Text(" Looking for").font(.subheadline).fontWeight(.light)
                                Spacer()
                                Picker(
                                    selection: $editedTypeOfDeveloper, label: Text("Looking for")) {
                                        Text("Android").tag(1)
                                        Text("iOS").tag(2)
                                        Text("Hybrid").tag(3)
                                    }
                                    .pickerStyle(.segmented)
                                    .compositingGroup()
                            }.padding(.vertical)
                    }
                    
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
                        })
                        .shadow(radius: 4, x: 2, y: 2)
                        
                        Button(action: {
                            db.pushUserDetails(
                                firstName: editedFirstName,
                                lastName: editedLastName,
                                companyName: "",
                                description: editedDescription,
                                linkedInLink: editedLinkedIn,
                                otherLink: editedOtherLink,
                                location: editedLocation,
                                githubLink: editedGithub,
                                typeOfDeveloper: editedTypeOfDeveloper,
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
                }.padding(25)
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
