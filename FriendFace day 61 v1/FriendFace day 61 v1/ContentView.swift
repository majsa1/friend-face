//
//  ContentView.swift
//  FriendFace day 61 v1
//
//  Created by Marjo Salo on 28/04/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @FetchRequest(entity: CDUser.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CDUser.name, ascending: true)]) private var savedUsers: FetchedResults<CDUser>

    var body: some View {
        
        NavigationView {
            
            List(savedUsers, id: \.id) { user in
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
            if savedUsers.isEmpty {
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
