//
//  ContentView.swift
//  FriendFace
//
//  Created by Marjo Salo on 20/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users = [User]()

    var body: some View {
        
        NavigationView {
            
            List(users, id: \.id) { user in
                NavigationLink(
                    destination: DetailView(user: user, users: users)) {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .fontWeight(.semibold)
                        Text("Age: \(user.age)")
                        Text("Company: \(user.company)")
                    }
                }
            }
            .navigationBarTitle(Text("FriendFace"))
            .coloredNavigationBar()
        }
        .onAppear(perform: {
            NetworkService.shared.getUsers { users in
                self.users = users
                self.users.sort { $0.name < $1.name }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
