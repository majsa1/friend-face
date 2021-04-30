//
//  CDFriend+CoreDataProperties.swift
//  FriendFace day 61 v1
//
//  Created by Marjo Salo on 28/04/2021.
//
//

import Foundation
import CoreData


extension CDFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var origin: CDUser?
    
    public var unwrappedName: String {
        name ?? "Unknown"
    }
    public var unwrappedId: String {
        id ?? "Unknown"
    }
}

extension CDFriend : Identifiable {

}
