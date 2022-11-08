//
//  MessageField.swift
//  InternPairing
//
//  Created by Saiman Chen on 2022-11-08.
//

import SwiftUI

struct MessageField: View {
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

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
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
