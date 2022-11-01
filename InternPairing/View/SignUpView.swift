import SwiftUI
import Firebase

// MARK: SignUpView
struct SignUpView: View {
    @EnvironmentObject var db: DataManager
    
    var body: some View {
        ZStack {
            if db.selected == 1 {
                StudentSignUp()
            }
            else if db.selected == 2 {
                RecruiterSignUp()
            }
        }.ignoresSafeArea()
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
        
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color("tertiaryColor"))
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 50)
                .fill(Color(.blue))
                .ignoresSafeArea()
                .offset(y: -100)
                .frame(height: UIScreen.main.bounds.height * 0.5)
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack {
                    Text("Register as Student").font(.title).bold()
                }
                .background(Color(.blue))
                .foregroundColor(.white)
                
                Spacer()
                
                RegisterStudentCardView(firstName: $firstName, lastName: $lastName, studentEmail: $studentEmail, studentPassword: $studentPassword, confirmStudentPassword: $confirmStudentPassword)
                
                Spacer()
                
                VStack {

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
                }
                Spacer()
            }
        }.ignoresSafeArea()
    }
}

struct RegisterStudentCardView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var studentEmail: String
    @Binding var studentPassword: String
    @Binding var confirmStudentPassword: String
    @ScaledMetric var width: CGFloat = 60
    @ScaledMetric var height: CGFloat = 40
    
    var body: some View {
        ZStack(alignment: .topLeading) {
           
            VStack {
                
                //TV Firstname - Lastname HStack
                //Input first-lastname hstack
                HStack {
                    VStack(alignment: .leading, spacing: 5){
                        Text(" Firstname:")
                        TextField("", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text(" Lastname:")
                        TextField("", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                Spacer().frame(height: 15)

                VStack(alignment: .leading, spacing: 5) {
                    Text(" Email:")
                    TextField("", text: $studentEmail)
                        .textFieldStyle(.roundedBorder)
                }
                Spacer().frame(height: 15)
                
                VStack {
                    HStack {
                        
                        VStack {
                            Text(" Date of Birth:")
                        }
                        Spacer()
                        VStack {
                            Button(action: {
                                
                            }, label: {
                                Text("Select")
                                    .padding(10)
                                    .background(.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(3)
                        })
                        }
                    }
                }
                
                Spacer().frame(height: 15)
                VStack {
                    //TV Password & Input för lösenord
                    VStack(alignment: .leading, spacing: 5) {
                        Text(" Password:")
                        SecureField("Password", text: $studentPassword)
                            .textFieldStyle(.roundedBorder)
                    }
                    Spacer().frame(height: 15)
                    //TV Confirm password & input
                    VStack(alignment: .leading, spacing: 5) {
                        Text(" Confirm password")
                        SecureField("Password", text: $confirmStudentPassword)
                            .textFieldStyle(.roundedBorder)
                    }
                }
            }
            .padding(25)
            .frame(
                width: UIScreen.main.bounds.width * 0.9,
                height: UIScreen.main.bounds.height * 0.6
            )
            .shadow(radius: 0.1, x: 0.3, y: 0.3)
            
            
            
            
        }
        .background(.white)
        .cornerRadius(40)
        .shadow(radius: 4, x: 2, y: 2)
        
    }
}

// MARK: DateOfBirthView
struct DateOfBirthView: View {
    @Binding var date: Date
    var body: some View {
        VStack {
            DatePicker("", selection: $date,
                       displayedComponents: [.date])
            .datePickerStyle(.wheel)
            .labelsHidden()
        }
    }
}

// MARK: Preview
struct SignUpView_Previews: PreviewProvider {
        
    static var previews: some View {
        StudentSignUp()
    }
}
