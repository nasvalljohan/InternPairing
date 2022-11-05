import SwiftUI
import _PhotosUI_SwiftUI

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


// MARK: RecruiterProfileView
struct RecruiterProfileView: View {
    @EnvironmentObject var db: DataManager
    var typeOf = TypeOf()
    
    var body: some View {
        
        //TODO: Implement:
        //            if let companyName = db.theUser?.companyName,
        //               let description = db.theUser?.description {
        //                let typeOfPosition = typeOf.typeOfPos(int: db.theUser?.typeOfPosition ?? 0)
        //                let typeOfDeveloper = typeOf.typeOfDev(int: db.theUser?.typeOfDeveloper ?? 0)
        let imageUrl = db.theUser?.imageUrl
            ZStack {
                Rectangle().fill(Color("tertiaryColor")).ignoresSafeArea()
                
                VStack (alignment: .trailing) {
                    NavigationLink(destination: {
                        //TODO: GO SOMEWHERE
                    }, label: {
                        Image(systemName: "gearshape.fill").resizable()
                            .frame(width: 25, height: 25)
                            .shadow(radius: 1, x: 1, y: 1)
                            .foregroundColor(Color("primaryColor"))
                            .padding(.horizontal)
                    }).padding(.horizontal)
                    
                    Spacer()
                    
                    HStack {
                        ZStack {
                            Rectangle().fill(Color("primaryColor")).frame(width: 60, height: 326).cornerRadius(10)
                            Text("About us").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 20, height: 180)
                        }.offset(x: -10).shadow(radius: 4, x: 2, y: 2).padding()
                        
                        ZStack{
                            if let imageUrl = imageUrl {
                                AsyncImage(url: URL(string: imageUrl), content: {
                                    pic in
                                    pic
                                        .resizable()
                                        .scaledToFill()
                                }, placeholder: {
                                    Image("profile-placeholder")
                                        .resizable()
                                        .scaledToFill()
                                }).frame(width: 220, height: 360)
                                    .cornerRadius(20)
                                    .clipped()
                                    .shadow(radius: 4, x: 2, y: 2)
                                
                            }
                            ProfilePhotosPickerView()
                        }
                        
                        ZStack {
                            Rectangle().fill(Color("primaryColor")).frame(width: 60, height: 326).cornerRadius(10)
                            Text("Portfolio").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 20, height: 180)
                        }.offset(x: 10).shadow(radius: 4, x: 2, y: 2).padding()
                        
                    }
                    
                    VStack {
                        VStack {
                            Text("Mr. Johnson").font(.title).fontWeight(.semibold)
                            Text("Mobile Interaction").font(.title3).fontWeight(.light)
                            Text("Stockholm").font(.subheadline).fontWeight(.light)
                        }
                        VStack {
                            Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec qu").lineLimit(4).font(.subheadline).fontWeight(.light).fixedSize(horizontal: false, vertical: true)
                        }.padding()
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                }
            }
        }
        
    }


// MARK: StudentProfileView
struct StudentProfileView: View {
    @EnvironmentObject var db: DataManager
    @EnvironmentObject var photoViewModel: PhotoPicker
    @EnvironmentObject var storageManager: StorageManager
    
    var ageConverter = DateFormatting()
    var typeOf = TypeOf()
    
    var body: some View {
        //TODO: Implement
        
        if let firstName = db.theUser?.firstName,
           let lastName = db.theUser?.lastName,
           let dateOfBirth = db.theUser?.dateOfBirth,
           let location = db.theUser?.location,
           let description = db.theUser?.description,
           let imageUrl = db.theUser?.imageUrl {
//           let typeOfDeveloper = typeOf.typeOfDev(int: db.theUser?.typeOfDeveloper ?? 0),
//           let dateString = ageConverter.dateToString(dateOfBirth: dateOfBirth),
//           let age = ageConverter.ageConverter(string: dateString)
            ZStack {
                Color("tertiaryColor").ignoresSafeArea()
                
                VStack (alignment: .trailing) {
                    NavigationLink(destination: {
                        //TODO: GO SOMEWHERE
                    }, label: {
                        Image(systemName: "gearshape.fill").resizable()
                            .frame(width: 25, height: 25)
                            .shadow(radius: 1, x: 1, y: 1)
                            .foregroundColor(Color("primaryColor"))
                            .padding(.horizontal)
                    }).padding(.horizontal)
                    
                    
                    Spacer()
                    
                    
                    HStack {
                        ZStack {
                            Rectangle().fill(Color("primaryColor")).frame(width: 60, height: 326).cornerRadius(10)
                            Text("Portfolio").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 20, height: 180)
                        }.offset(x: -10).shadow(radius: 4, x: 2, y: 2).padding()
                        
                        ZStack{
                            
                                AsyncImage(url: URL(string: imageUrl), content: {
                                    pic in
                                    pic
                                        .resizable()
                                        .scaledToFill()
                                }, placeholder: {
                                    Image("profile-placeholder")
                                        .resizable()
                                        .scaledToFill()
                                }).frame(width: 220, height: 360)
                                    .cornerRadius(20)
                                    .clipped()
                                    .shadow(radius: 4, x: 2, y: 2)
                            
                            ProfilePhotosPickerView()
                        }
                        
                        ZStack {
                            Rectangle().fill(Color("primaryColor")).frame(width: 60, height: 326).cornerRadius(10)
                            Text("Resume").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 20, height: 180)
                        }.offset(x: 10).shadow(radius: 4, x: 2, y: 2).padding()
                        
                    }
                    
                    VStack {
                        VStack {
                            HStack {
                                Text("\(firstName)").font(.title).fontWeight(.semibold)
                                Text("\(lastName)").font(.title).fontWeight(.semibold)
                            }
                            
                            Text("Android Developer").font(.title3).fontWeight(.light)
                            Text("\(location)").font(.subheadline).fontWeight(.light)
                        }
                        VStack {
                            Text("\(description)").lineLimit(4).font(.subheadline).fontWeight(.light).fixedSize(horizontal: false, vertical: true)
                        }.padding()
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                }
            }
        }
    }
}



// MARK: Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        StudentProfileView()
        RecruiterProfileView()
    }
}

struct ProfilePhotosPickerView: View {
    @EnvironmentObject var db: DataManager
    @EnvironmentObject var photoViewModel: PhotoPicker
    @EnvironmentObject var storageManager: StorageManager
    
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $photoViewModel.imageSelection,
                matching: .images,
                photoLibrary: .shared()) {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .frame(width: 20, height: 17)
                        .shadow(radius: 4, x: 2, y: 2)
                }.onChange(of: photoViewModel.data) { _ in
                    if let data = photoViewModel.data {
                        storageManager.uploadImage(image: data) { urlString in
                            
                            db.pushImage(imageUrl: urlString ?? "nil")
                        }
                    }
                }
        }
        .foregroundColor(Color("secondaryColor"))
        .padding(12)
        .background(Color("primaryColor"))
        .clipShape(Circle())
        .offset(x: 100, y: 165)
        .shadow(radius: 4, x: 2, y: 2)
    }
}

// TODO: Move to own file
struct TypeOf {
    func typeOfDev(int: Int) -> String {
        var str = ""
        
        switch int {
        case 1:
            str = "Android"
            break
        case 2:
            str = "iOS"
            break
        case 3:
            str = "React Native"
            break
        default:
            str = "Not specified"
            break
        }
        
        return str
    }
}
