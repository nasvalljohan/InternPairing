
import SwiftUI
import Firebase

// MARK: LoginView
struct LoginView: View {
    @EnvironmentObject var databaseConnection: DataManager
    @State var isNotAUser: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                if !isNotAUser {
                    AccountView(isNotAUser: $isNotAUser)
                } else {
                    NoAccountView(isNotAUser: $isNotAUser)
                }

            }
            .padding()
        }
    }
}

// MARK: AccountView
struct AccountView: View {
    
    @EnvironmentObject var databaseConnection: DataManager
    @State private var email = ""
    @State private var password = ""
    @Binding var isNotAUser: Bool

    var body: some View {
        VStack {
            Text("Login").font(.largeTitle)
            VStack {
                VStack (alignment: .leading) {
                    //Email
                    Text("E-mail:")
                    TextField("", text: $email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.roundedBorder)
                    //PW
                    Text("Password:")
                    SecureField("", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                
                //Login btn
                Button(action: {
                    databaseConnection.loginUser(email: email, password: password)
                }, label: {
                    Text("Login")
                        .padding()
                        .frame(width: 300)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
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
    @EnvironmentObject var databaseConnection: DataManager
    
    @Binding var isNotAUser: Bool

    var body: some View {
        NavigationView{
            VStack() {
                Text("Sign up").font(.largeTitle)
                HStack {
                    Text("I'm a")
                    VStack {
                        Picker(selection: $databaseConnection.selected, label: Text("Favorite Color")) {
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
                        print(databaseConnection.selected)
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
