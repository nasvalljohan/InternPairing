import SwiftUI

struct ChatRoomView: View {
    @EnvironmentObject var db: DataManager
    var messages: [Message]
    var internFirstName: String
    var internLastName: String
    var recruiterFirstName: String
    var recruiterLastName: String
    var internImage: String
    var recruiterImage: String
    
    var body: some View {
        ZStack {
            Color("tertiaryColor").ignoresSafeArea()
            VStack {
                TitleRowView(
                    firstname: db.theUser?.role == "Recruiter" ? internFirstName : recruiterFirstName,
                    lastname: db.theUser?.role == "Recruiter" ? internLastName : recruiterLastName
                )
                
                ScrollView {
                    ForEach(messages, id: \.self) { text in
                        ChatBubbleView(
                            message: Message(
                                id: text.id,
                                text: text.text,
                                received: text.received,
                                timestamp: text.timestamp),
                            image: db.theUser?.role == "Recruiter" ? internImage : recruiterImage
                        )
                    }
                }
                
//                MessageFieldView().padding(.horizontal)
            }
        }
    }
}

struct ChatBubbleView: View {
    var message: Message
    var image: String

    @State private var showTime = false
    
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            
            HStack {
                
                if message.received {
                    AsyncImage(url: URL(string: image)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .cornerRadius(50)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(message.text)
                    .padding()
                    .background(message.received ? Color("secondaryColor") : Color("primaryColor"))
                    .foregroundColor(message.received ? Color("primaryColor") : Color("tertiaryColor"))
                    .cornerRadius(10)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption)
                    .foregroundColor(Color(.lightGray))
                    .padding(message.received ? .leading : .trailing, 5)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.top)
    }
}

struct MessageFieldView: View {
    @State private var message = ""
    @Binding var messageArray: Array<String>
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Enter your message here"), text: $message)
            
            Button(action: {
                print("MESSAGE SENT!")
                messageArray.append(message)
                message = ""
            }, label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color("secondaryColor"))
                    .padding(10)
                    .background(Color("primaryColor"))
                    .cornerRadius(50)
            })
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("secondaryColor"))
        .cornerRadius(20)
        .padding()
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = { _ in }
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

struct TitleRowView: View {
    @Environment(\.dismiss) var dismiss
    
    var firstname: String
    var lastname: String
    
    var body: some View {
        
        ZStack {
            
            HStack(spacing: 25) {
                
                Text("<")
                    .font(.title)
                    .foregroundColor(Color("secondaryColor"))
                    .onTapGesture {
                        dismiss()
                    }
                
                Spacer()
                
                Text("\(firstname) \(lastname)")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color("secondaryColor"))
                
                Spacer()
                Spacer()
                
            }
            .padding(.horizontal)
            .padding(.bottom)
        .background(Color("primaryColor"))
        }.frame(maxWidth: .infinity).background(Color("primaryColor"))
        
        
    }
}
//
//struct ChatRoom_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatRoomView()
//    }
//}
