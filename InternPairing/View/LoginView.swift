
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
        VStack {
            ZStack{
                Circle().fill(Color("tertiaryColor")).frame(width: 100).offset(y: -30)
                Image(systemName: "ferry").resizable().frame(width: 50, height: 50).offset(y: -40)
                Text("fINNDäRN").font(.largeTitle).fontWeight(.light)
            }
            VStack {
                VStack (alignment: .leading) {
                    //Email

                    VStack {
                        TextField("Email", text: $email)
                        Divider()
                            .frame(width: 300)
                            .padding(.horizontal)
                            .background(Color.black)
                    }
                     .padding()
                    
                    //PW
                    VStack{
                        SecureField("Password", text: $password)
                        Divider()
                            .frame(width: 300)
                            .padding(.horizontal)
                            .background(Color.black)
                    }
                     .padding()
                }.padding()
                
                
                //Login btn
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
            }
        }
    }
}

// MARK: NoAccountView
struct NoAccountView: View {
    @EnvironmentObject var db: DataManager
    
    @Binding var isNotAUser: Bool

    var body: some View {
        NavigationView{
            VStack() {
                Text("Sign up").font(.largeTitle)
                HStack {
                    Text("I'm a")
                    VStack {
                        Picker(selection: $db.selected, label: Text("Favorite Color")) {
                            Text("Student").tag(1)
                            Text("Recruiter").tag(2)
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 150)
                        .offset(x: -20)
                    }
                }
                
                //Signup btn
                NavigationLink(destination:{
                    SignUpView()
                }, label: {
                    Text("Sign up")
                        .padding()
                        .frame(width: 300)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
                
                
                HStack {
                    Text("Already an user?")
                    Button(action: {
                        print(db.selected)
                        isNotAUser = false
                    }, label:{
                        Text("Login")
                    })
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
//            .environmentObject(DatabaseConnection())
    }
}
