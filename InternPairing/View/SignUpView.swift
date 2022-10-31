import SwiftUI
import Firebase

// MARK: SignUpView
struct SignUpView: View {
    @EnvironmentObject var db: DataManager
    
    var body: some View {
        
        if db.selected == 1 {
            StudentSignUp()
        }
        else if db.selected == 2 {
            RecruiterSignUp()
        }
    }
}

// MARK: RecruiterSignUp
struct RecruiterSignUp: View {
    @EnvironmentObject var db: DataManager
    
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
                    db.registerTheUser(email: companyEmail, password: companyPassword, dateOfBirth: Date(), firstName: "", lastName: "", gender: "", companyName: companyName, isUserComplete: false)
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
    @EnvironmentObject var db: DataManager
    var formatter = AgeConverter()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var studentEmail = ""
    @State var studentPassword = ""
    @State var confirmStudentPassword = ""
    @State private var date = Date()
    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {
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

                
                VStack(alignment: .leading) {
                    Text("Date of Birth:")
                    DatePicker("", selection: $date,
                               displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(height: 80)
                    .clipped()
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
                VStack {
                    Spacer()
                    Button(action: {
                        
                        db.registerTheUser(email: studentEmail, password: studentPassword, dateOfBirth: date, firstName: firstName, lastName: lastName, gender: "male", companyName: "", isUserComplete: false)
                        print(date)
                    }, label: {
                        Text("Next")
                            .padding()
                            .frame(width: 300)
                            .background(.gray)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                    })
                    Spacer()
                }
            }.padding()
        }
    }
    
    // MARK: Preview
    struct SignUpView_Previews: PreviewProvider {
        
        static var previews: some View {
            StudentSignUp()
        }
    }
}
