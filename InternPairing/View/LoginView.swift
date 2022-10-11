
import SwiftUI
import Firebase

struct LoginView: View {
    @StateObject var dataManager = DataManager()
    var authentication = Authentication()
    @State private var email = ""
    @State private var password = ""
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                
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
                    
                    //Login btn
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
                }
                
                Spacer()
                
                VStack {
                    Text("Not an user?")
                    Text("I'm a...")
                    HorizontalRadioGroupLayout()
                    
                    //Signup btn
                    Button(action: {
                        //authentication.registerUser(email: email, password: password)
                        print("hello")
                    }, label: {
                        Text("Sign up")
                            .padding()
                            .frame(width: 150)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(7)
                    })
                }
                
                Spacer()
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


struct HorizontalRadioGroupLayout: View {
    @State private var selected = 1
    var body: some View {
        VStack(spacing: 20) {
            Picker(selection: $selected, label: Text("Favorite Color")) {
                Text("Student").tag(1)
                Text("Recruiter").tag(2)
            }
            .pickerStyle(.segmented)
        }
        .padding(20)
        .border(Color.gray)
    }
}
