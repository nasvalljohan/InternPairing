
import SwiftUI
import Firebase

// MARK: LoginView
struct LoginView: View {
    @EnvironmentObject var db: DataManager
    @State var isUser: Bool = false
    @State private var email = ""
    @State private var password = ""

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
                if !isUser {
                    Login(email: $email, password: $password, isNotAUser: $isUser)
                }
                if isUser {
                    Register(isNotAUser: $isUser)
                }
                Spacer()
                
                //Login btn
                VStack{
                    if isUser {
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
                    }
                    if !isUser {
                        NavigationLink(destination:{
                            SignUpView().navigationBarBackButtonHidden(true)
                        }, label: {
                            Text("Sign up")
                                .padding()
                                .frame(width: 300)
                                .background(Color("primaryColor"))
                                .foregroundColor(Color("secondaryColor"))
                                .cornerRadius(10)
                        }).shadow(radius: 4, x: 2, y: 2)
                    }
                    HStack {
                        Text(isUser ? "Not registered?" : "Already an user?").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.light).offset(y: 10)

                        Button(action: {
                            isUser.toggle()
                        }, label: {
                            Text(isUser ? "Sign Up" : "Login").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.semibold).offset(y: 10)
                        })
                    }
                }.padding()
            }
        }
    }
}

//MARK:
struct Login: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var isNotAUser: Bool
    var body: some View {
        VStack (spacing: 0) {
            VStack {
                Text("Login").font(.title).fontWeight(.light)
            }.padding().offset(y: 40)
            VStack{
                VStack(alignment: .leading) {
                    Text(" Email:").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.light).offset(y: 10)
                    TextField("", text: $email)
                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                    Text(" Password:").foregroundColor(Color("primaryColor")).font(.subheadline).fontWeight(.light).offset(y: 10)
                    SecureField("", text: $password).textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                }.padding()
                
            }.frame(width: UIScreen.main.bounds.width * 0.9, height: 200).padding().offset(y: -10)
        }
    }
}

struct Register: View {
    @EnvironmentObject var db: DataManager
    @Binding var isNotAUser: Bool
    
    var body: some View {
        VStack (spacing: 0) {
            VStack {
                Text("Register as ").font(.title).fontWeight(.light)
            }.padding().offset(y: 40)
            VStack {
                Picker(selection: $db.selected, label: Text("Favorite Color")) {
                    Text("Student").tag(1)
                    Text("Recruiter").tag(2)
                }
                .pickerStyle(.wheel)
                .frame(height: 80)
                .clipped(antialiased: true)
            }.frame(width: UIScreen.main.bounds.width * 0.9, height: 200).padding().offset(y: -10)
        }
    }
}

// MARK: Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
