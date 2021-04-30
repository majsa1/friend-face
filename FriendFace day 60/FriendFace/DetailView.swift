//
//  DetailView.swift
//  FriendFace
//
//  Created by Marjo Salo on 20/04/2021.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selection: String? = nil
    
    let user: User
    let users: [User]
    
    var body: some View {
      
        VStack(alignment: .leading, spacing: 15) {
        
            HStack {
                Text("Age:")
                    .fontWeight(.semibold)
                Text("\(user.age)")
            }
            HStack {
                Text("E-mail:")
                    .fontWeight(.semibold)
                Text(user.email)
            }
            VStack(alignment: .leading) {
                Text("Address:")
                    .fontWeight(.semibold)
                Text((user.address))
            }
            VStack(alignment: .leading) {
                Text("About \(user.name):")
                    .fontWeight(.semibold)
                    .padding(.bottom, 5.0)
                   
                ScrollView {
                    Text(user.about)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            
            Text("Friends of \(user.name):")
                .fontWeight(.semibold)
                .padding(.bottom, 5.0)
        
            List(user.friends, id: \.id) { friend in
                NavigationLink(
                    destination: DetailView(user: getUser(from: friend), users: users),
                    tag: friend.id,
                    selection: $selection,
                    label: {
                        Text(friend.name)
                    })
                .isDetailLink(false) // to be able to return to home with one dismiss() call
            }
            .cornerRadius(10)
            .shadow(radius: 2)
            
            HStack {
                HStack {
                    Text("Status:")
                        .fontWeight(.semibold)
                    Text(user.isActive ? "🟢" : "🔴")
                }
                Spacer()
                HStack {
                    Text("Registered since:")
                        .fontWeight(.semibold)
                    Text(user.registrationDate)
                }
            }
            .font(.system(size: 12))
            
            HStack {
                Text("Tags:")
                    .fontWeight(.semibold)
                Text(user.tags.joined(separator: ", "))
                    .font(.footnote).italic()
            }
            .font(.system(size: 12))
        }
        .padding()
        .navigationBarItems(trailing:
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "house")
                                })
        .navigationBarTitle(Text(user.name), displayMode: .inline)
        .onAppear(perform: {
            selection = nil
        }) // to be able to move back and forth between the same users while using .isDetailLink
    }
    func getUser(from friend: Friend) -> User {
        users.first(where: { $0.id == friend.id }) ?? user
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let user = User(id: "d467f82e-4a40-4af9-975d-0312874c2748", isActive: false, name: "Aimee Newman", age: 37, company: "Animalia", email: "aimeenewman@animalia.com", address: "181 Virginia Place, Gwynn, Iowa, 5600", about: "Ut exercitation aliqua in nostrud culpa veniam adipisicing fugiat sit nulla. Aliquip esse consequat irure veniam culpa exercitation magna culpa quis et in quis nisi veniam. Nisi cupidatat culpa reprehenderit reprehenderit incididunt adipisicing.\r\n", registered: Date(), tags: ["occaecat", "Lorem", "magna", "et", "qui", "nisi", "reprehenderit"], friends: [Friend(id: "3e6fa1d2-527c-41e9-9da0-2d89eb0b8d6a", name: "Brooks Spence"), Friend(id: "8be513e0-b46d-40cc-b617-a295a26525de", name: "Virginia Glover"), Friend(id: "29e0f9ee-71f2-4043-ad36-9d2d6789b2c8", name: "Pace English")])
    
    static var previews: some View {
        DetailView(user: user, users: [User]())
    }
}
