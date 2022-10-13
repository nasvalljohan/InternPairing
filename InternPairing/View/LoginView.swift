
import SwiftUI
import Firebase

// MARK: LoginView
struct LoginView: View {
    @StateObject var dataManager = DataManager()
    @State var authentication = Authentication()
    @State var isNotAUser: Bool = false
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        ZStack{
            VStack {
//                if !isNotAUser {
//                    AccountView(isNotAUser: $isNotAUser, authentication: $authentication)
//                } else {
//                    NoAccountView(isNotAUser: $isNotAUser)
//                }
                NoAccountView(dataManager: dataManager, authentication: $authentication, isNotAUser: $isNotAUser)
                
            }
            .padding()
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        isUserLoggedIn.toggle()
                    }
                }
            }
        }
    }
}

// MARK: AccountView
struct AccountView: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var isNotAUser: Bool
    @Binding var authentication: Authentication
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
                    authentication.loginUser(email: email, password: password)
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
    @ObservedObject var dataManager: DataManager
    
    @Binding var authentication: Authentication
    @Binding var isNotAUser: Bool
    @State private var selected = 1
    var body: some View {
        NavigationView{
            VStack() {
                Text("Sign up").font(.largeTitle)
                HStack {
                    Text("I'm a")
                    VStack {
                        Picker(selection: $selected, label: Text("Favorite Color")) {
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
                    SignUpView(dataManager: dataManager, selected: $selected, authentication: $authentication)
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
                        isNotAUser = false
                    }, label:{
                        Text("Login")
                    })
                }
            }
        }
    }
}

// MARK: HorizontalRadioGroupLayout
struct HorizontalRadioGroupLayout: View {
    @State private var selected = 1
    var body: some View {
        VStack {
            Picker(selection: $selected, label: Text("Favorite Color")) {
                Text("Student").tag(1)
                Text("Recruiter").tag(2)
            }
            .pickerStyle(.wheel)
            .frame(width: 150)
            .offset(x: -20)
        }
//        .border(Color.gray)
    }
}

// MARK: Preview
struct LoginView_Previews: PreviewProvider {
    @Binding var isUserLoggedIn: Bool
    static var previews: some View {
        LoginView(isUserLoggedIn: .constant(true))
    }
}
