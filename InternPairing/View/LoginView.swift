
import SwiftUI
import Firebase

// MARK: LoginView
struct LoginView: View {
    @EnvironmentObject var databaseConnection: DatabaseConnection
    @State var isNotAUser: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                if !isNotAUser {
                    AccountView(isNotAUser: $isNotAUser)
                } else {
                    NoAccountView(isNotAUser: $isNotAUser)
                }
//                NoAccountView(databaseConnection: databaseConnection, isNotAUser: $isNotAUser)
                
            }
            .padding()
        }
    }
}

// MARK: AccountView
struct AccountView: View {
    
    @EnvironmentObject var databaseConnection: DatabaseConnection
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
    @EnvironmentObject var databaseConnection: DatabaseConnection
    
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
                    SignUpView(selected: $selected)
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
        LoginView()
    }
}
