
import SwiftUI
import PhotosUI

struct UserDetailsView: View {
    
    @EnvironmentObject var db: DataManager
    var body: some View {
        ZStack {
            
            if db.theUser?.role == "Recruiter" {
                RecruiterDetailsView()
            } else if db.theUser?.role == "Intern" {
                InternDetailsView()
            }
        }
    }
}

// MARK: Recruiter view
struct RecruiterDetailsView: View {
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
                
                DetailsPhotosPickerView()
                
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
                    
                    if let data = photoViewModel.data {
                        storageManager.uploadImage(image: data) { urlString in
                            db.pushUserDetails(
                                description: description,
                                linkedInLink: linkedIn,
                                otherLink: "",
                                location: location,
                                githubLink: "",
                                typeOfDeveloper: typeOfDeveloper,
                                companyLink: companyLink,
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


//MARK: Intern View
struct InternDetailsView: View {
    
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
                
                DetailsPhotosPickerView()
                
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
                
                Button(action: {
                    if let data = photoViewModel.data {
                        storageManager.uploadImage(image: data) { urlString in
                            db.pushUserDetails(
                                description: description,
                                linkedInLink: linkedIn,
                                otherLink: "",
                                location: location,
                                githubLink: github,
                                typeOfDeveloper: typeOfDeveloper,
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

// MARK: PhotosPickerView
struct DetailsPhotosPickerView: View {
    @EnvironmentObject var photoViewModel: PhotoPicker
    
    var body: some View {
        ZStack {
            if let data = photoViewModel.data,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 2, y: 2)
                
            } else {
                Image(systemName: "person.crop.circle").resizable()
                    .frame(width: 200, height: 200).scaledToFit().clipShape(Circle())
                    .foregroundColor(Color("tertiaryColor"))
                    .shadow(radius: 4, x: 2, y: 2)
            }
            
            VStack{
                PhotosPicker(
                    selection: $photoViewModel.imageSelection,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .frame(width: 20, height: 17)
                            .shadow(radius: 4, x: 2, y: 2)
                    }
            }
            .foregroundColor(Color("secondaryColor"))
            .padding(12)
            .background(Color("primaryColor"))
            .clipShape(Circle())
            .offset(x: 65, y: 65)
            .shadow(radius: 4, x: 2, y: 2)
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
