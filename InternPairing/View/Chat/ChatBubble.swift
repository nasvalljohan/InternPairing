//
//  ChatBubble.swift
//  InternPairing
//
//  Created by Saiman Chen on 2022-11-08.
//

import SwiftUI

struct ChatBubble: View {
    var message: Message
    @State private var showTime = false
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            
            HStack {
                
                if message.received {
                    AsyncImage(url: imageUrl) { image in
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
//        .padding(.top)
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(message: Message(
            id: "123",
            text: "Hi friend, we need to speak. ASAP!",
            received: true,
            timestamp: Date()))
    }
}
