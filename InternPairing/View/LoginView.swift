
import SwiftUI
import Firebase

struct LoginView: View {
    var authentication = Authentication()
    @State private var email = ""
    @State private var password = ""
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        ZStack{
            VStack {
                
                //Email
                Text("E-mail:")
                TextField("", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
                
                //PW
                Text("Password:")
                SecureField("", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                //Signup btn
                Button(action: {
                    authentication.registerUser(email: email, password: password)
                }, label: {
                    Text("Sign up")
                        .padding()
                        .frame(width: 150)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                })
                
                //Login btn
                Button(action: {
                    authentication.loginUser(email: email, password: password)
                    print(isUserLoggedIn)
                }, label: {
                    Text("Login")
                        .padding()
                        .frame(width: 150)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                })
            }
            .padding()
            .onAppear{
//                authentication.isUserLoggedIn(isUserLoggedIn: isUserLoggedIn)
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        isUserLoggedIn.toggle()
                    }
                }
                print(isUserLoggedIn)
            }
        }
    }
}
