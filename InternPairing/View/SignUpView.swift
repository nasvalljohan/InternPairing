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
    @State var date = Date()
    @State var showSheet = false
    @State var isDateSelected = false
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
                    Text("Jobbig Tinder")
                        .bold()
                        .foregroundColor(Color("tertiaryColor"))
                }
                .background(Color("primaryColor"))
                .foregroundColor(.white)
                
                Spacer().frame(height: 30)
                
                RegisterStudentCardView(firstName: $firstName, lastName: $lastName, studentEmail: $studentEmail, studentPassword: $studentPassword, confirmStudentPassword: $confirmStudentPassword, showSheet: $showSheet, isDateSelected: $isDateSelected, date: $date
                )
                
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
                DateOfBirthView(date: $date, showSheet: $showSheet, isDateSelected: $isDateSelected)
                    .presentationDetents([.fraction(0.5)])
                
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
    @Binding var isDateSelected: Bool
    @Binding var date: Date
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
                                .textFieldModifier(backgroundColor: Color("tertiaryColor"))
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text(" Lastname:")
                            TextField("", text: $lastName)
                                .textFieldModifier(backgroundColor: Color("tertiaryColor"))
                        }
                    }
                    Spacer().frame(height: 15)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(" Email:")
                        TextField("", text: $studentEmail)
                            .textFieldModifier(backgroundColor: Color("tertiaryColor"))
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
                                
                                if !isDateSelected {
                                    Text("YYYY-MM-DD")
                                        .padding(8)
                                        .foregroundColor(Color("primaryColor"))
                                } else {
                                    Text("\(date)")
                                        .padding(8)
                                        .foregroundColor(Color("primaryColor"))
                                }
                                    
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
                        SecureField("", text: $studentPassword)
                            .textFieldModifier(backgroundColor: Color("tertiaryColor"))
                    }
                    Spacer().frame(height: 15)
                    //TV Confirm password & input
                    VStack(alignment: .leading, spacing: 5) {
                        Text(" Confirm password")
                        SecureField("", text: $confirmStudentPassword)
                            .textFieldModifier(backgroundColor: Color("tertiaryColor"))
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
    @Binding var showSheet: Bool
    @Binding var isDateSelected: Bool
    var body: some View {
        VStack() {
            Spacer()
            Text("Date of birth:")
                .font(.title)
                .foregroundColor(Color("primaryColor"))
            Spacer()
            DatePicker("", selection: $date,
                       displayedComponents: [.date])
            .datePickerStyle(.wheel)
            .labelsHidden()
//            .colorInvert()
            .colorMultiply(Color("primaryColor"))
            .frame(height: 80)
            .clipped()
            Spacer()
            Button(action: {
                showSheet.toggle()
                isDateSelected.toggle()
            }, label: {
                Text("Choose")
                    .padding()
                    .bold()
                    .frame(width: 300)
                    .background(Color("primaryColor"))
                    .foregroundColor(Color("secondaryColor"))
                    .cornerRadius(10)
            })
            Spacer()
        }
    }
}

struct TextFieldModifier: ViewModifier {
    let fontSize: CGFloat
    let backgroundColor: Color
    let textColor: Color

    func body(content: Content) -> some View {
        content
            .font(Font.system(size: fontSize))
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 5).fill(backgroundColor))
            .foregroundColor(textColor)
    }
}

extension View {
    func textFieldModifier(fontSize: CGFloat = 14, backgroundColor: Color = .blue, textColor: Color = .white) -> some View {
        self.modifier(TextFieldModifier(fontSize: fontSize, backgroundColor: backgroundColor, textColor: textColor))
    }
}

// MARK: Preview
struct SignUpView_Previews: PreviewProvider {
        
    static var previews: some View {
        StudentSignUp()
    }
}
