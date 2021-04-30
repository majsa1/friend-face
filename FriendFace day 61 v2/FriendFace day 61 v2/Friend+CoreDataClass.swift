//
//  Friend+CoreDataClass.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case name, id
      }
    
    required convenience public init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderFailure.contextMissing
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
    }
}
