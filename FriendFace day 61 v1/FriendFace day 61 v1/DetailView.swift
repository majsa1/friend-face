//
//  DetailView.swift
//  FriendFace day 61 v1
//
//  Created by Marjo Salo on 28/04/2021.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: CDUser.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CDUser.name, ascending: true)]) private var savedUsers: FetchedResults<CDUser>
    
    @State private var selection: String? = nil
    
    var user: CDUser
    
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
                Text(user.unwrappedEmail)
            }
            VStack(alignment: .leading) {
                Text("Address:")
                    .fontWeight(.semibold)
                Text((user.unwrappedAddress))
            }
            VStack(alignment: .leading) {
                Text("About \(user.unwrappedName):")
                    .fontWeight(.semibold)
                    .padding(.bottom, 5.0)
                   
                ScrollView {
                    Text(user.unwrappedAbout)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            
            Text("Friends of \(user.unwrappedName):")
                .fontWeight(.semibold)
                .padding(.bottom, 5.0)
        
            List(user.friendsArray, id: \.id) { friend in
                NavigationLink(
                    destination: DetailView(user: getUser(from: friend)),
                    tag: friend.unwrappedId,
                    selection: $selection,
                    label: {
                        Text(friend.unwrappedName)
                    })
                .isDetailLink(false) 
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
                Text(user.unwrappedTags)
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
        .navigationBarTitle(Text(user.unwrappedName), displayMode: .inline)
        .onAppear(perform: {
            selection = nil
        }) 
    }
    func getUser(from friend: CDFriend) -> CDUser {
        savedUsers.first(where: { $0.id == friend.id }) ?? user
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(user: CDUser())
    }
}
