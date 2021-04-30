//
//  User+CoreDataClass.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable {

    enum CodingKeys: CodingKey {
        case name, id, isActive, age, company, email, address, about, registered, tags, friends
      }
    
    required convenience public init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderFailure.contextMissing
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.friends = try container.decode(Set<Friend>.self, forKey: .friends) as NSSet
        
        let fetchedTags = try container.decode([String].self, forKey: .tags)
        
        for tag in fetchedTags {
            let newTag = Tag(context: context)
            newTag.name = tag
            self.addToTags(newTag)
        }
    }
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum DecoderFailure: Error {
    case contextMissing
}

