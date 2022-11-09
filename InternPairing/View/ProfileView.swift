import SwiftUI
import _PhotosUI_SwiftUI

// MARK: ProfileView
struct ProfileView: View {
    @EnvironmentObject var db: DataManager
    var body: some View {
        if let u = db.theUser {
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
                    VStack {
                        if u.role == "Intern" {
                            InternView()
                        }
                        if u.role == "Recruiter" {
                            RecruiterView()
                        }
                    }
                    Spacer()
                    
                }
            }
            
        }
    }
}

struct RecruiterView: View {
    @EnvironmentObject var db: DataManager
    
    var body: some View {
        if let u = db.theUser {
            VStack {
                HStack {
                    ZStack {
                        Rectangle().fill(Color("primaryColor")).frame(width: 60, height: 326).cornerRadius(10)
                        Text("About us").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                            .rotationEffect(.degrees(-90))
                            .fixedSize()
                            .frame(width: 20, height: 180)
                    }.offset(x: -10).shadow(radius: 4, x: 2, y: 2).padding()
                    
                    ZStack{
                        
                        AsyncImage(url: URL(string: u.imageUrl ?? "profile-placeholder"), content: {
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
                        Text(u.companyName ?? "").font(.title).fontWeight(.semibold)
                        HStack {
                            Text(u.firstName ?? "").font(.title3).fontWeight(.light)
                            Text(u.lastName ?? "").font(.title3).fontWeight(.light)
                        }
                        //TODO: Add recruiter location?
                        Text("Stockholm").font(.subheadline).fontWeight(.light)
                    }
                    VStack {
                        Text(u.description ?? "").lineLimit(4).font(.subheadline).fontWeight(.light).fixedSize(horizontal: false, vertical: true)
                    }.padding()
                }.padding(.horizontal)
            }
        }
    }
}



struct InternView: View {
    @EnvironmentObject var db: DataManager
    
    var body: some View {
        if let u = db.theUser,
            let dateOfBirth = db.theUser?.dateOfBirth {
            let dateString = formatter.dateToString(dateOfBirth: dateOfBirth)
            let age = formatter.ageConverter(string: dateString)
            
            VStack {
                HStack {
                    ZStack {
                        Rectangle().fill(Color("primaryColor")).frame(width: 60, height: 326).cornerRadius(10)
                        Text("Portfolio").font(.title3).fontWeight(.light).foregroundColor(Color("tertiaryColor"))
                            .rotationEffect(.degrees(-90))
                            .fixedSize()
                            .frame(width: 20, height: 180)
                    }.offset(x: -10).shadow(radius: 4, x: 2, y: 2).padding()
                    
                    ZStack{
                        AsyncImage(url: URL(string: u.imageUrl ?? ""), content: {
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
                            Text(u.firstName ?? "").font(.title).fontWeight(.semibold)
                            Text(u.lastName ?? "").font(.title).fontWeight(.semibold)
                            Text(age).font(.title2).fontWeight(.ultraLight).frame(alignment: .bottom)
                        }
                        
                        Text(formatter.typeOfDev(int: db.theUser?.typeOfDeveloper ?? 0) ).font(.title3).fontWeight(.light)
                        Text(u.location ?? "").font(.subheadline).fontWeight(.light)
                    }
                    VStack {
                        Text(u.description ?? "").lineLimit(4).font(.subheadline).fontWeight(.light).fixedSize(horizontal: false, vertical: true)
                    }.padding()
                }.padding(.horizontal)
            }
        }
    }
}


// MARK: Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(DataManager())
    }
}

// MARK: ProfilePhotosPickerView
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

