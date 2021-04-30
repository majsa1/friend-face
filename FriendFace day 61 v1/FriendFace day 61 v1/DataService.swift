//
//  NetworkService.swift
//  FriendFace day 61 v1
//
//  Created by Marjo Salo on 28/04/2021.
//

import Foundation
import CoreData

class DataService {
    static let shared = DataService()

    func getUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedUsers = try? decoder.decode([User].self, from: data) {
                    
                let moc = PersistenceController.shared.container.viewContext
                let privateMoc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                privateMoc.parent = moc

                privateMoc.performAndWait {
                    for user in decodedUsers {
                        let savedUser = CDUser(context: moc)
                        savedUser.id = user.id
                        savedUser.isActive = user.isActive
                        savedUser.name = user.name
                        savedUser.age = Int16(user.age)
                        savedUser.company = user.company
                        savedUser.email = user.email
                        savedUser.address = user.address
                        savedUser.about = user.about
                        savedUser.registered = user.registered
                        savedUser.tags = user.tags.joined(separator: ", ")

                        for friend in user.friends {
                            let savedFriend = CDFriend(context: moc)
                            savedFriend.id = friend.id
                            savedFriend.name = friend.name
                            savedUser.addToFriends(savedFriend)
                        }
                    }
                    do {
                        try privateMoc.save()
                        moc.performAndWait {
                            do {
                                try moc.save()
                                print("Saved \(decodedUsers.count) users in core data")
                            } catch {
                                print("Failure to save context: \(error)")
                            }
                        }
                    } catch {
                        print("Failure to save private context: \(error)")
                    }
                }
            } else {
                print("Failure to decode: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        .resume()
    }
}
