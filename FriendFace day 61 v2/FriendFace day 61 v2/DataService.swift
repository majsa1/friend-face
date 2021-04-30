//
//  DataService.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//

import Foundation
import CoreData

class DataService {

    static let shared = DataService()
    
    func getUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        let moc = PersistenceController.shared.container.viewContext
        let privateMoc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMoc.parent = moc
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            privateMoc.performAndWait {
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = moc
            
            if let decodedUsers = try? decoder.decode([User].self, from: data) {
      
                    do {
                        try privateMoc.save()
                        moc.performAndWait {
                            do {
                                try moc.save()
                                print("Saved \(decodedUsers.count) users in Core Data")
                            } catch {
                                print("Failed to save context: \(error)")
                            }
                        }
                    } catch {
                        print("Failed to save private context: \(error)")
                    }
                } else {
                    print("Failed to decode: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        .resume()
    }
}
