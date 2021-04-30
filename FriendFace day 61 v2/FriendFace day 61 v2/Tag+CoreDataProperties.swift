//
//  Tag+CoreDataProperties.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String? 
    @NSManaged public var origin: User?

    public var unwrappedTag: String {
        name ?? "Unknown"
    }
}

extension Tag : Identifiable {

}
