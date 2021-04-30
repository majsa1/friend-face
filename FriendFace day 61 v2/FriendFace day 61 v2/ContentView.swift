//
//  ContentView.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)]) private var users: FetchedResults<User>

    var body: some View {
        
        NavigationView {
            
            List(users, id: \.id) { user in
                NavigationLink(
                    destination: DetailView(user: user)) {
                    VStack(alignment: .leading) {
                        Text(user.unwrappedName)
                            .fontWeight(.semibold)
                        Text("Age: \(user.age)")
                        Text("Company: \(user.unwrappedCompany)")
                    }
                }
            }
            .navigationBarTitle(Text("FriendFace"))
            .coloredNavigationBar()
        }
        .onAppear(perform: {
            if users.isEmpty {
                DataService.shared.getUsers()
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
