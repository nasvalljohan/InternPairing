
import SwiftUI

struct UserDetailsView: View {
    @ObservedObject var databaseConnection: DatabaseConnection
    var body: some View {
        
        if databaseConnection.userRecruiter?.role == "recruiter" {
            RecruiterDetailsView()
        } else if databaseConnection.userIntern?.role == "student" {
                InternDetailsView()
            }
    }
}


// MARK: Recruiter view
struct RecruiterDetailsView: View {
    @State var description = ""
    @State var linkedIn = ""
    @State var location = ""
    @State var website = ""
    @State var selectedPlatform = 0
    @State var selectedPosition = 0
    
    var body: some View {
        ZStack {
            VStack {
                Text("Profile Information")
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Company description:")
                    TextEditor(text: $description)
                        .frame(
                            height: UIScreen.main.bounds.height * 0.25
                        ).border(.teal)
                    
                    Text("LinkedIn:")
                    TextField("", text: $linkedIn)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Website:")
                    TextField("", text: $website)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Location:")
                    TextField("", text: $location)
                        .textFieldStyle(.roundedBorder)
                }
                
                Spacer()
                
                VStack {
                    GeometryReader { geometry in
                        
                        HStack(spacing: 0) {
                            Picker(
                                selection: $selectedPlatform, label: Text("I am")) {
                                    Text("We're looking for..").tag(0)
                                    Text("Android Dev").tag(1)
                                    Text("iOS Dev").tag(2)
                                    Text("React Native Dev").tag(3)
                                }
                                .pickerStyle(.menu)
                                .frame(
                                    width: geometry.size.width/2,
                                    height: geometry.size.height,
                                    alignment: .center)
                                .compositingGroup()
                                .clipped()
                            
                            Picker(
                                selection: $selectedPosition,
                                label: Text("as..")) {
                                    Text("as..").tag(0)
                                    Text("Fullstack").tag(1)
                                    Text("FrontEnd").tag(2)
                                    Text("BackEnd").tag(3)
                                }
                                .pickerStyle(.menu)
                                .frame(
                                    width: geometry.size.width/2,
                                    height: geometry.size.height,
                                    alignment: .center)
                                .compositingGroup()
                                .clipped()
                        }
                    }
                }
                Button(action: {
                    print("hello")
                }, label: {
                    Text("Save")
                        .padding()
                        .frame(width: 300)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
            }.padding()
        }
    }
}


//MARK: Intern View
struct InternDetailsView: View {
    @State var description = ""
    @State var linkedIn = ""
    @State var location = ""
    @State var github = ""
    @State var selectedPlatform = 0
    @State var selectedPosition = 0
    var body: some View {
        ZStack {
            VStack {
                Text("Profile Information")
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Description:")
                    TextEditor(text: $description)
                        .frame(
                            height: UIScreen.main.bounds.height * 0.25
                        ).border(.teal)
                    
                    Text("LinkedIn:")
                    TextField("", text: $linkedIn)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Github:")
                    TextField("", text: $github)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Location:")
                    TextField("", text: $location)
                        .textFieldStyle(.roundedBorder)
                }
                
                Spacer()
                
                VStack {
                    GeometryReader { geometry in
                        
                        HStack(spacing: 0) {
                            Picker(
                                selection: $selectedPlatform, label: Text("I am")) {
                                    Text("I am a..").tag(0)
                                    Text("Android Dev").tag(1)
                                    Text("iOS Dev").tag(2)
                                    Text("React Native Dev").tag(3)
                                }
                                .pickerStyle(.menu)
                                .frame(
                                    width: geometry.size.width/2,
                                    height: geometry.size.height,
                                    alignment: .center)
                                .compositingGroup()
                                .clipped()
                            
                            Picker(
                                selection: $selectedPosition,
                                label: Text("Looking for:")) {
                                    Text("looking for..").tag(0)
                                    Text("Fullstack").tag(1)
                                    Text("FrontEnd").tag(2)
                                    Text("BackEnd").tag(3)
                                }
                                .pickerStyle(.menu)
                                .frame(
                                    width: geometry.size.width/2,
                                    height: geometry.size.height,
                                    alignment: .center)
                                .compositingGroup()
                                .clipped()
                        }
                    }
                }
                Button(action: {
                    print("hello")
                }, label: {
                    Text("Save")
                        .padding()
                        .frame(width: 300)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
            }.padding()
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(databaseConnection: DatabaseConnection())
    }
}
