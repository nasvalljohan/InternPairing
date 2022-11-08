//
//  TitleRow.swift
//  InternPairing
//
//  Created by Saiman Chen on 2022-11-08.
//

import SwiftUI
var imageUrl = URL(string: "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1085&q=80")

var name = "Saiman Chen"
struct TitleRowView: View {
    var body: some View {
        
        ZStack {
            
            HStack(spacing: 25) {
                
                Text("<")
                    .foregroundColor(Color("secondaryColor"))
                    .bold()
                Spacer()
                
                Text(name)
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

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRowView()
    }
}
