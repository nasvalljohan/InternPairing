//
//  UserView.swift
//  InternPairing
//
//  Created by Saiman Chen on 2022-10-10.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            List(dataManager.userInterns, id: \.id) { user in
                Text(user.name)
                
            }
            .navigationTitle("UserInterns")
            .navigationBarItems(trailing: Button(action: {
                // add
            }, label: {
                Image(systemName: "plus")
            }))
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
