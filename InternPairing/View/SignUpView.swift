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
                    Text("Jinder").font(.title).bold()
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
                    db.registerUser(email: companyEmail, password: companyPassword, dateOfBirth: Date(), firstName: "", lastName: "", gender: "", companyName: companyName, isUserComplete: false)
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
    @State var showSheet = false
    var body: some View {
        
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color("tertiaryColor"))
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 50)
                .fill(Color("primaryColor"))
                .ignoresSafeArea()
                .offset(y: -100)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .shadow(radius: 4, x: 2, y: 2)
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack {
                    Text("Jobbig Tinder").bold()
                }
                .background(Color("primaryColor"))
                .foregroundColor(.white)
                
                Spacer().frame(height: 30)
                
                RegisterStudentCardView(firstName: $firstName, lastName: $lastName, studentEmail: $studentEmail, studentPassword: $studentPassword, confirmStudentPassword: $confirmStudentPassword, showSheet: $showSheet)
                
                Spacer()
                
                VStack {

                    Button(action: {
                        
                        db.registerUser(email: studentEmail, password: studentPassword, dateOfBirth: date, firstName: firstName, lastName: lastName, gender: "male", companyName: "", isUserComplete: false)
                        print(date)
                    }, label: {
                        Text("Next")
                            .padding()
                            .frame(width: 300)
                            .background(Color("primaryColor"))
                            .foregroundColor(Color("secondaryColor"))
                            .cornerRadius(10)
                    }).shadow(radius: 4, x: 2, y: 2)
                }
                Spacer()
            }.sheet(isPresented: $showSheet) {
                DateOfBirthView(date: $date)
                
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
    @Binding var showSheet: Bool
    var body: some View {
        ZStack(alignment: .topLeading) {
           
            VStack {
                Spacer()
                Text("Register as Student")
                    .font(.title)
                    .foregroundColor(Color("primaryColor"))
                Spacer().frame(height: 30)
                VStack {
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
                }
                Spacer().frame(height: 20)
                
                VStack {
                    HStack {
                        
                        VStack {
                            Text(" Date of Birth:")
                        }
                        Spacer()
                        VStack {
                            Button(action: {
                                showSheet.toggle()
                            }, label: {
                                Text("YYYY-MM-DD")
                                    .padding(8)
                                    .foregroundColor(Color("primaryColor"))
                                    
                                    
                            })
                        }
                        Spacer()
                        
                    }
                }
                
                Spacer().frame(height: 20)
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
                Spacer()
            }
            .padding(25)
            .frame(
                width: UIScreen.main.bounds.width * 0.9,
                height: UIScreen.main.bounds.height * 0.65
            )
            .shadow(radius: 0.1, x: 0.3, y: 0.3)
            
            
            
            
        }
        .background(Color("secondaryColor"))
        .cornerRadius(30)
        .shadow(radius: 4, x: 2, y: 2)
        
    }
}

// MARK: DateOfBirthView
struct DateOfBirthView: View {
    @Binding var date: Date
    var body: some View {
        VStack {
            Text("Choose your date of birth:")
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
