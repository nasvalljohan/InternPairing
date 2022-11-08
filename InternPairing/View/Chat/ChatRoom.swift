import SwiftUI

struct ChatRoom: View {
    var messageArray = ["Hello you sexy one!", "We need to speak asap :)", "What do you think about us?", "Are we good?"]
    
    var body: some View {
        ZStack {
            Color("tertiaryColor").ignoresSafeArea()
            VStack {
                TitleRow()
                ScrollView {
                    ForEach(messageArray, id: \.self) { text in
                        ChatBubble(message: Message(
                            id: "123",
                            text: text,
                            received: true,
                            timestamp: Date()))
                    }
                }
                
                MessageField().padding(.horizontal)
            }
        }
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom()
    }
}
