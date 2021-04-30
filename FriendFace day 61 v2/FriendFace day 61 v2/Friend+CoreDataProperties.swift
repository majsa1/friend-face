//
//  Friend+CoreDataProperties.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var origin: User?
    
    public var unwrappedName: String {
        name ?? "Unknown"
    }
    public var unwrappedId: String {
        id ?? "Unknown"
    }

}

extension Friend : Identifiable {

}
