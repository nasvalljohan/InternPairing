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
    // navigate back
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var db: DataManager
    
    @State var firstName = ""
    @State var lastName = ""
    @State var companyName = ""
    @State var companyEmail = ""
    @State var companyPassword = ""
    @State var confirmCompanyPassword = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color("tertiaryColor").ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 50)
                .fill(Color("primaryColor"))
                .ignoresSafeArea()
                .offset(y: -100)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .shadow(radius: 4, x: 2, y: 2)
            
            VStack {
                Spacer()

                ZStack(alignment: .topLeading) {
                    VStack {
                        Text("Register as Recruiter")
                            .font(.title)
                            .foregroundColor(Color("primaryColor"))
                            .padding()
                        Spacer()
                        VStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 5){
                                    Text(" Firstname:").foregroundColor(Color(.lightGray))
                                    TextField("", text: $firstName)
                                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                }
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(" Lastname:").foregroundColor(Color(.lightGray))
                                    TextField("", text: $lastName)
                                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                }
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                Text(" Company name:").foregroundColor(Color(.lightGray))
                                TextField("", text: $companyName)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                Text(" E-mail:").foregroundColor(Color(.lightGray))
                                TextField("", text: $companyEmail)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                Text(" Password:").foregroundColor(Color(.lightGray))
                                SecureField("", text: $companyPassword)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                Text(" Confirm password:").foregroundColor(Color(.lightGray))
                                SecureField("", text: $confirmCompanyPassword)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                            Spacer()
                            
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(
                        width: UIScreen.main.bounds.width * 0.9,
                        height: UIScreen.main.bounds.height * 0.6
                    )
                    .shadow(radius: 0.1, x: 0.3, y: 0.3)
                }
                .background(Color("secondaryColor"))
                .cornerRadius(15)
                .shadow(radius: 4, x: 2, y: 2)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text(Image(systemName: "arrow.uturn.backward"))
                            .padding()
                            .frame(width: 60)
                            .background(Color("primaryColor"))
                            .foregroundColor(Color("secondaryColor"))
                            .cornerRadius(10)
                    }).shadow(radius: 4, x: 2, y: 2)
                    
                    
                    Button(action: {
                        db.registerUser(email: companyEmail, password: companyPassword, dateOfBirth: Date(), firstName: firstName, lastName: lastName, companyName: companyName, isUserComplete: false)
                    }, label: {
                        Text("Next")
                            .padding()
                            .frame(width: 250)
                            .background(Color("primaryColor"))
                            .foregroundColor(Color("secondaryColor"))
                            .cornerRadius(10)
                    }).shadow(radius: 4, x: 2, y: 2)
                }
                Spacer()
            }
        }
    }
}

// MARK: StudentSignUp
struct StudentSignUp: View {
    // navigate back
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var db: DataManager
    var formatter = DateFormatting()
    
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
                
                ZStack(alignment: .topLeading) {
                    
                    VStack {
                        Spacer()
                        Text("Register as Student")
                            .font(.title)
                            .foregroundColor(Color("primaryColor"))
                        Spacer()
                        VStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 5){
                                    Text(" Firstname:").foregroundColor(Color(.lightGray))
                                    TextField("", text: $firstName)
                                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                }
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(" Lastname:").foregroundColor(Color(.lightGray))
                                    TextField("", text: $lastName)
                                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(" Email:").foregroundColor(Color(.lightGray))
                                TextField("", text: $studentEmail)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                        }
                        
                        VStack {
                            
                            HStack {
                                VStack {
                                    Text(" Date of Birth:").foregroundColor(Color(.lightGray))
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
                                            Text(formatter.dateToString(dateOfBirth: date))
                                                .padding(8)
                                                .foregroundColor(Color("primaryColor"))
                                                .bold()
                                        }
                                    })
                                }.frame(width: 150).background(Color("tertiaryColor")).cornerRadius(5)
                                
                            }
                        }.padding(.vertical)
                        
                        VStack {
                            //TV Password & Input för lösenord
                            VStack(alignment: .leading, spacing: 5) {
                                Text(" Password:").foregroundColor(Color(.lightGray))
                                SecureField("", text: $studentPassword)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                            Spacer().frame(height: 15)
                            //TV Confirm password & input
                            VStack(alignment: .leading, spacing: 5) {
                                Text(" Confirm password").foregroundColor(Color(.lightGray))
                                SecureField("", text: $confirmStudentPassword)
                                    .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(
                        width: UIScreen.main.bounds.width * 0.9,
                        height: UIScreen.main.bounds.height * 0.65
                    )
                    .shadow(radius: 0.1, x: 0.3, y: 0.3)
                }
                .background(Color("secondaryColor"))
                .cornerRadius(15)
                .shadow(radius: 4, x: 2, y: 2)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text(Image(systemName: "arrow.uturn.backward"))
                            .padding()
                            .frame(width: 60)
                            .background(Color("primaryColor"))
                            .foregroundColor(Color("secondaryColor"))
                            .cornerRadius(10)
                    }).shadow(radius: 4, x: 2, y: 2)
                    
                    Button(action: {
                        
                        db.registerUser(email: studentEmail, password: studentPassword, dateOfBirth: date, firstName: firstName, lastName: lastName, companyName: "", isUserComplete: false)
                        print(date)
                    }, label: {
                        Text("Next")
                            .padding()
                            .frame(width: 250)
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
                isDateSelected = true
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
//        RecruiterSignUp()
        StudentSignUp()
    }
}
