import SwiftUI
import Firebase

// MARK: SignUpView
struct SignUpView: View {
    @ObservedObject var databaseConnection: DatabaseConnection
    
    @Binding var selected: Int
    var body: some View {
        
        if selected == 1 {
            StudentSignUp(databaseConnection: databaseConnection)
        }
        else if selected == 2 {
            RecruiterSignUp()
        }
        
    }
}

//// MARK: Preview
//struct SignUpView_Previews: PreviewProvider {
//    @Binding var selected: Int
//    @Binding var authentication: Authentication
//    static var previews: some View {
//        SignUpView(selected: .constant(1), authentication: .constant(Authentication()), dataManager: .constant()
//    }
//}

// MARK: RecruiterSignUp
struct RecruiterSignUp: View {
    @State var companyName = ""
    @State var companyEmail = ""
    @State var companyPassword = ""
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                //TW Register as recruiter
                VStack (alignment: .leading) {
                    Text("Register as").font(.title).bold()
                    Text("Recruiter").font(.title).bold()
                }
                
                
                //TW Company Name & Input för company name
                VStack{
                    Text("Company name:")
                    TextField("Tjena", text: $companyName)
                        .frame(width: 150)
                }.padding()
                
                //TW Email & Input för email
                VStack{
                    Text("Email:")
                    TextField("Email", text: $companyEmail)
                        .frame(width: 150)
                }.padding()
                
                //TW Password & Input för lösenord
                VStack{
                    Text("Password:")
                    SecureField("Password", text: $companyPassword)
                        .frame(width: 150)
                }
                
                //TW Confirm password & input
                VStack{
                    Text("Confirm password")
                    SecureField("Password", text: $companyPassword)
                        .frame(width: 150)
                }.padding()
                
                Button(action: {
                    //Go somewhere
                    print("Go somewhere")
                }, label: {
                    Text("Button")
                })
                
                Spacer()
                
            }
            
        }
        
    }
}

// MARK: StudentSignUp
struct StudentSignUp: View {
    @ObservedObject var databaseConnection: DatabaseConnection
    
    @State var firstName = ""
    @State var lastName = ""
    @State var studentEmail = ""
    @State var studentPassword = ""
    
    var body: some View {
        
        ZStack{
            VStack{
                Spacer()
                
                //TW Register as student
                VStack (alignment: .leading) {
                    Text("Register as").font(.title).bold()
                    Text("Student").font(.title).bold()
                }
                
                //TW Firstname - Lastname HStack
                //Input first-lastname hstack
                HStack{
                    VStack {
                        Text("Firstname")
                        TextField("FirstName", text: $firstName)
                            .frame(width: 150)
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack {
                        Text("Lastname")
                        TextField("LastName", text: $lastName)
                            .frame(width: 150)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                //TW Email
                //Input email
                VStack{
                    Text("Email:")
                    TextField("Email", text: $studentEmail)
                        .frame(width: 150)
                        .textFieldStyle(.roundedBorder)
                }.padding()
                
                //TW Password & Input för lösenord
                VStack{
                    Text("Password:")
                    SecureField("Password", text: $studentPassword)
                        .frame(width: 150)
                        .textFieldStyle(.roundedBorder)
                }
                
                //TW Confirm password & input
                VStack{
                    Text("Confirm password")
                    SecureField("Password", text: $studentPassword)
                        .frame(width: 150)
                        .textFieldStyle(.roundedBorder)
                }.padding()
                
                Button(action: {
                    
                    databaseConnection.registerUserIntern(email: studentEmail, password: studentPassword, dateOfBirth: Date(), firstName: firstName, lastName: lastName, gender: "male")
                    

                    
                    
                }, label: {
                    Text("write db")
                })
                
                Spacer()
                //TW Date of birth
                //Hstack year-month-day
                
            }
        }
        
        
        
        
    }
}
