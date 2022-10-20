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
            RecruiterSignUp(databaseConnection: databaseConnection)
        }
        
    }
}

// MARK: RecruiterSignUp
struct RecruiterSignUp: View {
    @ObservedObject var databaseConnection: DatabaseConnection
    
    @State var companyName = ""
    @State var companyEmail = ""
    @State var companyPassword = ""
    @State var confirmCompanyPassword = ""
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer()
                
                //TW Register as recruiter
                VStack {
                    Text("Register as Recruiter").font(.title).bold()
                }
                
                Spacer()
                
                
                //TW Company Name & Input för company name
                VStack(alignment: .leading) {
                    Text("Company name:")
                    TextField("Tjena", text: $companyName)
                        .textFieldStyle(.roundedBorder)
                }
                
                //TW Email & Input för email
                VStack(alignment: .leading) {
                    Text("Email:")
                    TextField("Email", text: $companyEmail)
                        .textFieldStyle(.roundedBorder)
                }
                
                //TW Password & Input för lösenord
                VStack(alignment: .leading) {
                    Text("Password:")
                    SecureField("Password", text: $companyPassword)
                        .textFieldStyle(.roundedBorder)
                }
                
                //TW Confirm password & input
                VStack(alignment: .leading) {
                    Text("Confirm password:")
                    SecureField("Password", text: $confirmCompanyPassword)
                        .textFieldStyle(.roundedBorder)
                }
                
                Spacer()
                
                Button(action: {
                    databaseConnection.registerUserRecruiter(email: companyEmail, password: companyPassword, companyName: companyName)
                }, label: {
                    Text("Next")
                        .padding()
                        .frame(width: 300)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
                
                Spacer()
            }.padding()
            
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
    @State var confirmStudentPassword = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Spacer()
                
                //TV Register as student
                VStack (alignment: .leading) {
                    Text("Register as Student").font(.title).bold()
                }.padding()
                
                Spacer()
                
                //TV Firstname - Lastname HStack
                //Input first-lastname hstack
                HStack {
                    VStack(alignment: .leading){
                        Text("Firstname")
                        TextField("FirstName", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack(alignment: .leading) {
                        Text("Lastname")
                        TextField("LastName", text: $lastName)

                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                //TV Email
                //Input email
                VStack(alignment: .leading) {
                    Text("Email:")
                    TextField("Email", text: $studentEmail)
                        .textFieldStyle(.roundedBorder)
                }

                
                //TV Password & Input för lösenord
                VStack(alignment: .leading) {
                    Text("Password:")
                    SecureField("Password", text: $studentPassword)
                        .textFieldStyle(.roundedBorder)
                }
                
                //TV Confirm password & input
                VStack(alignment: .leading) {
                    Text("Confirm password")
                    SecureField("Password", text: $confirmStudentPassword)
                        .textFieldStyle(.roundedBorder)
                }
                Spacer()
                
                Button(action: {
                    databaseConnection.registerUserIntern(email: studentEmail, password: studentPassword, dateOfBirth: Date(), firstName: firstName, lastName: lastName, gender: "male")
                }, label: {
                    Text("write db")
                        .padding()
                        .frame(width: 300)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                })
                
                Spacer()
                //TW Date of birth
                //Hstack year-month-day
                
            }.padding()
        }
    }
    
    // MARK: Preview
    struct SignUpView_Previews: PreviewProvider {
        @ObservedObject var databaseConnection: DatabaseConnection
        @Binding var selected: Int
        
        static var previews: some View {
            SignUpView(databaseConnection: DatabaseConnection(), selected: .constant(1))
        }
    }
}
