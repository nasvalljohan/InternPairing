
import SwiftUI
import PhotosUI

struct UserDetailsView: View {
    @EnvironmentObject var photosPickerModel: PhotoPicker
    @EnvironmentObject var databaseConnection: DataManager
    var body: some View {
        ZStack {
            
            if databaseConnection.theUser?.role == "Recruiter" {
                RecruiterDetailsView()
            } else if databaseConnection.theUser?.role == "Intern" {
                InternDetailsView(imageState: photosPickerModel.imageState)
            }
        }
    }
}


// MARK: Recruiter view
struct RecruiterDetailsView: View {
    @EnvironmentObject var databaseConnection: DataManager
    @State var description = ""
    @State var linkedIn = ""
    @State var location = ""
    @State var website = ""
    @State var typeOfDeveloper = 0
    @State var typeOfPosition = 0
    @State var imageUrl = ""
    
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
                    databaseConnection.addUserDetails(description: description, linkedInLink: linkedIn, otherLink: "", location: location, githubLink: "", typeOfDeveloper: typeOfDeveloper, typeOfPosition: typeOfPosition, companyLink: website, imageUrl: imageUrl)
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
    let imageState: PhotoPicker.ImageState
    @EnvironmentObject var databaseConnection: DataManager
    @EnvironmentObject var photosPickerModel: PhotoPicker
    @StateObject var storageConnection = StorageManager()

    @State var description = ""
    @State var linkedIn = ""
    @State var location = ""
    @State var github = ""
    @State var typeOfDeveloper = 0
    @State var typeOfPosition = 0
    @State var imageUrl = ""
    
    var body: some View {
        ZStack {
            
            ScrollView {
                
                ZStack {
                    if let data = photosPickerModel.data,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage).resizable()
                            .frame(width: 200, height: 200).scaledToFit().clipShape(Circle())
                        
                    } else {
                        Image("profile-placeholder").resizable()
                            .frame(width: 200, height: 200).clipShape(Circle())
                    }
                    
                    VStack{
                        PhotosPicker(
                            selection: $photosPickerModel.imageSelection,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .frame(width: 20, height: 17)
                            }
                    }
                    .foregroundColor(.black)
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
                    
                    if let data = photosPickerModel.data {
                        
                        storageConnection.uploadImage(image: data) { urlString in
                            databaseConnection.addUserDetails(
                                description: description,
                                linkedInLink: linkedIn,
                                otherLink: "",
                                location: location,
                                githubLink: github,
                                typeOfDeveloper: typeOfDeveloper,
                                typeOfPosition: typeOfPosition,
                                companyLink: "",
                                imageUrl: urlString ?? "nil"
                            )
                        }
                        }
                        
                        
                        
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

//struct UserDetailsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        InternDetailsView()
//        //RecruiterDetailsView()
//    }
//}
