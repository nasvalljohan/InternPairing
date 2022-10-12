import SwiftUI

struct SignUpView: View {
    var body: some View {
        //RecruiterSignUp()
        StudentSignUp()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

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

struct StudentSignUp: View {
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
                    }
                    VStack {
                        Text("Lastname")
                        TextField("LastName", text: $lastName)
                            .frame(width: 150)
                    }
                }
                
                //TW Email
                //Input email
                VStack{
                    Text("Email:")
                    TextField("Email", text: $studentEmail)
                        .frame(width: 150)
                }.padding()
                
                //TW Password & Input för lösenord
                VStack{
                    Text("Password:")
                    SecureField("Password", text: $studentPassword)
                        .frame(width: 150)
                }
                
                //TW Confirm password & input
                VStack{
                    Text("Confirm password")
                    SecureField("Password", text: $studentPassword)
                        .frame(width: 150)
                }.padding()
                
                
                Spacer()
                //TW Date of birth
                //Hstack year-month-day
                
            }
        }
        
        

        
    }
}
