
import SwiftUI
import PhotosUI

struct UserDetailsView: View {
    @EnvironmentObject var photoViewModel: PhotoPicker
    @EnvironmentObject var db: DataManager
    var body: some View {
        ZStack {
            
            if db.theUser?.role == "Recruiter" {
                RecruiterDetailsView()
            } else if db.theUser?.role == "Intern" {
                InternDetailsView(imageState: photoViewModel.imageState)
            }
        }
    }
}


// MARK: Recruiter view
struct RecruiterDetailsView: View {
    @EnvironmentObject var db: DataManager
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
                    db.pushUserDetails(description: description, linkedInLink: linkedIn, otherLink: "", location: location, githubLink: "", typeOfDeveloper: typeOfDeveloper, typeOfPosition: typeOfPosition, companyLink: website, imageUrl: imageUrl)
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
    @EnvironmentObject var db: DataManager
    @EnvironmentObject var photoViewModel: PhotoPicker
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
            Color("tertiaryColor").ignoresSafeArea()
            
            
            VStack {
                
                Spacer()
                
                ZStack {
                    if let data = photoViewModel.data,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage).resizable()
                            .frame(width: 200, height: 200).scaledToFit().clipShape(Circle())
                        
                    } else {
                        Image(systemName: "person.crop.circle").resizable()
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color("secondaryColor"))
                    }
                    
                    VStack{
                        PhotosPicker(
                            selection: $photoViewModel.imageSelection,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .frame(width: 20, height: 17)
                            }
                    }
                    .foregroundColor(Color("secondaryColor"))
                    .padding(12)
                    .background(Color("primaryColor"))
                    .clipShape(Circle())
                    .offset(x: 65, y: 65)
                }
                
                Spacer()
                
                ZStack {
                    Color("secondaryColor")
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Description:")
                            TextEditor(text: $description)
                                .frame(
                                    height: UIScreen.main.bounds.height * 0.2
                                ).border(.teal)
                            
                            Text("LinkedIn:")
                            TextField("", text: $linkedIn)
                                .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            
                            Text("Github:")
                            TextField("", text: $github)
                                .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            
                            Text("Location:")
                            TextField("", text: $location)
                                .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                        }
                        
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
                    }
                    .padding(25)
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
                    
                    if let data = photoViewModel.data {
                        storageConnection.uploadImage(image: data) { urlString in
                            db.pushUserDetails(
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

//struct UserDetailsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        InternDetailsView()
//        //RecruiterDetailsView()
//    }
//}
