import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct LoginView: View {
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
                    // sign up
                }, label: {
                    Text("Sign up")
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
