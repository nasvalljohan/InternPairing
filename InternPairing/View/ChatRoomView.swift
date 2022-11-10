import SwiftUI

struct ChatRoomView: View {
    @EnvironmentObject var db: DataManager
    @State private var text = ""
    @Binding var currentDocID: String
    var chatPerson: TheUser
    var imageUrl = "https://images.unsplash.com/photo-1668063497279-7ecb0f0ffa8a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80"
    
    var body: some View {
        ZStack {
            Color("tertiaryColor").ignoresSafeArea()
            VStack {
                TitleRowView(
                    firstname: chatPerson.firstName ?? "",
                    lastname: chatPerson.lastName ?? ""
                )
                
                ScrollView {
                    ForEach(db.messages, id: \.self) { text in
                        ChatBubbleView(
                            message: Message(
                                id: text.id,
                                text: text.text,
                                received: text.received,
                                timestamp: text.timestamp),
                            image: chatPerson.imageUrl ?? ""
                        )
                    }
                }
                
                HStack {
                    CustomTextField(placeholder: Text("Enter your message here"), text: $text)
                    
                    Button(action: {
                        print("MESSAGE SENT!")
                        db.pushMessages(message: Message(id: "\(UUID())", text: text, received: false, timestamp: Date.now), documentID: self.currentDocID)
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
                .padding(.horizontal)
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
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Enter your message here"), text: $message)
            
            Button(action: {
                print("MESSAGE SENT!")
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
    
    @EnvironmentObject var db: DataManager
    
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
                        print(db.messages)
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
