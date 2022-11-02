
import SwiftUI
import Firebase

// MARK: LoginView
struct LoginView: View {
    @EnvironmentObject var db: DataManager
    @State var isNotAUser: Bool = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color("tertiaryColor"))
                .ignoresSafeArea()
            VStack {
                if !isNotAUser {
                    AccountView(isNotAUser: $isNotAUser)
                } else {
                    NoAccountView(isNotAUser: $isNotAUser)
                }

            }
        }
    }
}

// MARK: AccountView
struct AccountView: View {
    
    @EnvironmentObject var db: DataManager
    @State private var email = ""
    @State private var password = ""
    @Binding var isNotAUser: Bool

    var body: some View {
        ZStack {
            Color("tertiaryColor").ignoresSafeArea()
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("secondaryColor"))
                .frame(height: UIScreen.main.bounds.height * 0.3)
                .shadow(radius: 4, x: 2, y: 2).padding()
            VStack {
                Spacer()
                ZStack{
                    Circle().fill(Color("secondaryColor")).frame(width: 100).offset(y: -40)
                    Image(systemName: "ferry").resizable().frame(width: 50, height: 50).offset(y: -40)
                    Text("fINNDäRN").font(.largeTitle).fontWeight(.light)
                }
                
                VStack{
                    VStack(alignment: .leading) {
                        Text(" Email:").foregroundColor(Color(.lightGray))
                        
                        TextField("", text: $email)
                            .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                    }.padding()
                    VStack(alignment: .leading){
                        Text(" Password:").foregroundColor(Color(.lightGray))
                        SecureField("", text: $password).textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                    }.padding()
                }.frame(width: UIScreen.main.bounds.width * 0.9, height: 200).padding().offset(y: -10)
                
                
                Spacer()
                //Login btn
                VStack{
                    Button(action: {
                        db.loginUser(email: email, password: password)
                    }, label: {
                        Text("Login")
                            .padding()
                            .frame(width: 300)
                            .background(Color("primaryColor"))
                            .foregroundColor(Color("secondaryColor"))
                            .cornerRadius(10)
                    }).shadow(radius: 4, x: 2, y: 2)
                    HStack {
                        Text("Not an user?")
                        Button(action: {
                            isNotAUser = true
                        }, label: {
                            Text("Sign up")
                        })
                    }
                }.padding()
            }
        }
    }
}

// MARK: NoAccountView
struct NoAccountView: View {
    
    @EnvironmentObject var db: DataManager
    @Binding var isNotAUser: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("tertiaryColor").ignoresSafeArea()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("secondaryColor"))
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    .shadow(radius: 4, x: 2, y: 2).padding()
                VStack {
                    Spacer()
                    ZStack{
                        Circle().fill(Color("secondaryColor")).frame(width: 100).offset(y: -40)
                        Image(systemName: "ferry").resizable().frame(width: 50, height: 50).offset(y: -40)
                        Text("fINNDäRN").font(.largeTitle).fontWeight(.light)
                    }
                    VStack {
                        Text("I'm a").font(.title3).fontWeight(.light)
                            Picker(selection: $db.selected, label: Text("Favorite Color")) {
                                Text("Student").tag(1)
                                Text("Recruiter").tag(2)
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 150, height: 50)
                            .offset(x: -10)
                    }.frame(width: UIScreen.main.bounds.width * 0.9, height: 200).padding().offset(y: -10)
                    Spacer()
                    //Signup btn
                    VStack {NavigationLink(destination:{
                        SignUpView()
                    }, label: {
                        Text("Sign up")
                            .padding()
                            .frame(width: 300)
                            .background(Color("primaryColor"))
                            .foregroundColor(Color("secondaryColor"))
                            .cornerRadius(10)
                    }).shadow(radius: 4, x: 2, y: 2)
                        
                        HStack {
                            Text("Already an user?")
                            Button(action: {
                                print(db.selected)
                                isNotAUser = false
                            }, label:{
                                Text("Login")
                            })
                        }
                    }.padding()
                }
            }
        }
    }
}




// MARK: Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
//        LoginView()
        AccountView(isNotAUser: .constant(true))
        .environmentObject(DataManager())
//        NoAccountView(isNotAUser: .constant(false))
//            .environmentObject(DataManager())
    }
}
