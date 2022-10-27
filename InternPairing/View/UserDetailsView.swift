
import SwiftUI
import PhotosUI

struct UserDetailsView: View {
    @EnvironmentObject var databaseConnection: DatabaseConnection
    var body: some View {
        
        if databaseConnection.theUser?.role == "Recruiter" {
            RecruiterDetailsView()
        } else if databaseConnection.theUser?.role == "Intern" {
            InternDetailsView()
        }
    }
}


// MARK: Recruiter view
struct RecruiterDetailsView: View {
    @EnvironmentObject var databaseConnection: DatabaseConnection
    @State var description = ""
    @State var linkedIn = ""
    @State var location = ""
    @State var website = ""
    @State var typeOfDeveloper = 0
    @State var typeOfPosition = 0
    
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
                                selection: $typeOfDeveloper, label: Text("I am")) {
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
                                selection: $typeOfPosition,
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
                    print("Trying to update")
                    databaseConnection.addUserDetails(description: description, linkedInLink: linkedIn, otherLink: "", location: location, githubLink: "", typeOfDeveloper: typeOfDeveloper, typeOfPosition: typeOfPosition, companyLink: website)
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
    @EnvironmentObject var databaseConnection: DatabaseConnection
    @StateObject var storageConnection = StorageConnection()
    
    @State private var selectedItem: PhotosPickerItem? = nil
     @State private var selectedImageData: Data? = nil
    @State var description = ""
    @State var linkedIn = ""
    @State var location = ""
    @State var github = ""
    @State var typeOfDeveloper = 0
    @State var typeOfPosition = 0
    @State var imageUrl = ""
    var body: some View {
        ZStack {
            VStack {
                
                ZStack {
                    
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {
                        Image(uiImage: uiImage).resizable()
                            .frame(width: 200, height: 200).scaledToFit().clipShape(Circle())
                        
                    } else {
                        Image("profile-placeholder").resizable()
                            .frame(width: 200, height: 200).clipShape(Circle())
                    }
                    
                    VStack{
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .frame(width: 20, height: 17)
                            }            .onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                        
                                        // Push to storage
                                        storageConnection.uploadImage(image: data)
                                    }
                                }
                            }
                        
                    }  .foregroundColor(.black)
                        .padding(12)
                        .background(Color.gray)
                        .clipShape(Circle())
                        .offset(x: 65, y: 65)
                }
                
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
                                selection: $typeOfDeveloper, label: Text("I am")) {
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
                                selection: $typeOfPosition,
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
                    databaseConnection.addUserDetails(
                        description: description,
                        linkedInLink: linkedIn,
                        otherLink: "",
                        location: location,
                        githubLink: github,
                        typeOfDeveloper: typeOfDeveloper,
                        typeOfPosition: typeOfPosition,
                        companyLink: "")

                    databaseConnection.addImage(imageUrl: storageConnection.stringUrl)
                        
                        print("button has been pressed")
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

        InternDetailsView()
        //RecruiterDetailsView()
    }
}
