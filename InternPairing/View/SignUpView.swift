import SwiftUI
import Firebase

// MARK: SignUpView
struct SignUpView: View {
    @EnvironmentObject var db: DataManager
    @Environment(\.dismiss) var dismiss
    
    @State var firstName = ""
    @State var lastName = ""
    @State var companyName = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var date = Date()
    @State var showSheet = false
    @State var isDateSelected = false
    
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
                        Spacer()
                        if db.selected == 1 {
                            InternCard(firstName: $firstName, lastName: $lastName, email: $email, password: $password, confirmPassword: $confirmPassword, date: $date, showSheet: $showSheet, isDateSelected: $isDateSelected)
                        }
                        if db.selected == 2 {
                            RecruiterCard(firstName: $firstName, lastName: $lastName, companyName: $companyName, email: $email, password: $password, confirmPassword: $confirmPassword)
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
                        db.registerUser(email: email, password: password, dateOfBirth: date, firstName: firstName, lastName: lastName, companyName: companyName, isUserComplete: false)
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

//MARK: INTERNCARD
struct InternCard: View {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var date: Date
    @Binding var showSheet: Bool
    @Binding var isDateSelected: Bool
    
    var body: some View {
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
                    TextField("", text: $email)
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
                    SecureField("", text: $password)
                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                }
                Spacer().frame(height: 15)
                //TV Confirm password & input
                VStack(alignment: .leading, spacing: 5) {
                    Text(" Confirm password").foregroundColor(Color(.lightGray))
                    SecureField("", text: $confirmPassword)
                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                }
            }
            Spacer()
        }
    }
}

//MARK: RECRUITER CARD
struct RecruiterCard: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var companyName: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    
    var body: some View {
        VStack {
            VStack{
                Spacer()
                Text("Register as Recruiter")
                    .font(.title)
                    .foregroundColor(Color("primaryColor"))
                    .padding()
                Spacer()
            }
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
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(" Company name:").foregroundColor(Color(.lightGray))
                    TextField("", text: $companyName)
                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text(" E-mail:").foregroundColor(Color(.lightGray))
                    TextField("", text: $email)
                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text(" Password:").foregroundColor(Color(.lightGray))
                    SecureField("", text: $password)
                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text(" Confirm password:").foregroundColor(Color(.lightGray))
                    SecureField("", text: $confirmPassword)
                        .textFieldModifier(backgroundColor: Color("tertiaryColor"),textColor: Color("primaryColor"))
                }
            }
            Spacer()
        }
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

// MARK: Preview
struct SignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignUpView()
            .environmentObject(DataManager())
    }
}
