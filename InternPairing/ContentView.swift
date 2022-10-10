import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LoginView()
        }
        .padding()
    }
}

struct LoginView: View {
    var authentication = Autentication()
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            VStack {
                Text("E-mail:")
                TextField("", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
                
                Text("Password:")
                SecureField("", text: $password)
                    .textFieldStyle(.roundedBorder)
                
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
                
                Button(action: {
                    authentication.loginUser(email: email, password: password)
                }, label: {
                    Text("Login")
                        .padding()
                        .frame(width: 150)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                })
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
