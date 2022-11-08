import SwiftUI
import _PhotosUI_SwiftUI

// MARK: ProfileView
struct ProfileView: View {
    @EnvironmentObject var um: UserManager
    var body: some View {
        VStack{
            if um.theUser.role == "Recruiter" {
                RecruiterProfileView()
            }
            if um.theUser.role == "Intern" {
                StudentProfileView()
            }
        }
    }
}


// MARK: RecruiterProfileView
struct RecruiterProfileView: View {
    @EnvironmentObject var um: UserManager
    
    var body: some View {
        
        if let companyName = um.theUser.companyName,
           let firstName = um.theUser.firstName,
           let lastName = um.theUser.lastName {

            ZStack {
                Rectangle().fill(Color("tertiaryColor")).ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: {
                            EditProfileView()
                        }, label: {
                            Image(systemName: "gearshape.fill").resizable()
                                .frame(width: 25, height: 25)
                                .shadow(radius: 1, x: 1, y: 1)
                                .foregroundColor(Color("primaryColor"))
                                .padding(.horizontal)
                        }).padding(.horizontal)
                    }
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
                            
                            AsyncImage(url: URL(string: um.theUser.imageUrl ?? ""), content: {
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
                            Text("Portfolio").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 20, height: 180)
                        }.offset(x: 10).shadow(radius: 4, x: 2, y: 2).padding()
                        
                    }
                    
                    VStack(alignment: .center) {
                        VStack {
                            Text(companyName).font(.title).fontWeight(.semibold)
                            HStack {
                                Text(firstName).font(.title3).fontWeight(.light)
                                Text(lastName).font(.title3).fontWeight(.light)
                            }
                            //TODO: Add recruiter location?
                            Text("Stockholm").font(.subheadline).fontWeight(.light)
                        }
                        VStack {
                            Text(um.theUser.description ?? "Not specified").lineLimit(4).font(.subheadline).fontWeight(.light).fixedSize(horizontal: false, vertical: true)
                        }.padding()
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                }
            }
        }
    }
        
    }


// MARK: StudentProfileView
struct StudentProfileView: View {
    @EnvironmentObject var um: UserManager
    @EnvironmentObject var photoViewModel: PhotoPicker
    @EnvironmentObject var storageManager: StorageManager
    
    var formatter = Formatter()
    
    var imageUrl: String?
    
    var body: some View {
        if let firstName = um.theUser.firstName,
           let lastName = um.theUser.lastName,
           let dateOfBirth = um.theUser.dateOfBirth {
            let dateString = formatter.dateToString(dateOfBirth: dateOfBirth)
            let age = formatter.ageConverter(string: dateString)

            ZStack {
                Color("tertiaryColor").ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: {
                            EditProfileView()
                        }, label: {
                            Image(systemName: "gearshape.fill").resizable()
                                .frame(width: 25, height: 25)
                                .shadow(radius: 1, x: 1, y: 1)
                                .foregroundColor(Color("primaryColor"))
                                .padding(.horizontal)
                        }).padding(.horizontal)
                    }
                    
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
                            AsyncImage(url: URL(string: um.theUser.imageUrl ?? ""), content: {
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
                                Text(firstName).font(.title).fontWeight(.semibold)
                                Text(lastName).font(.title).fontWeight(.semibold)
                                Text(age).font(.title2).fontWeight(.ultraLight).frame(alignment: .bottom)
                            }
                            
                            Text(formatter.typeOfDev(int: um.theUser.typeOfDeveloper ?? 0) ).font(.title3).fontWeight(.light)
                            Text(um.theUser.location ?? "Not specified lol").font(.subheadline).fontWeight(.light)
                        }
                        VStack {
                            Text(um.theUser.description ?? "No description").lineLimit(4).font(.subheadline).fontWeight(.light).fixedSize(horizontal: false, vertical: true)
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

// MARK: ProfilePhotosPickerView
struct ProfilePhotosPickerView: View {
    @EnvironmentObject var um: UserManager
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
                        
                        //TODO: STORAGE SINGLETON ADD TO PUSHIMAGE IN USERMANAGER
                        storageManager.uploadImage(image: data) { urlString in
                            
                        um.pushImage(imageUrl: urlString ?? "nil")
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

