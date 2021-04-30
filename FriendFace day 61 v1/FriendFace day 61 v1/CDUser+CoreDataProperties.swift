//
//  CDUser+CoreDataProperties.swift
//  FriendFace day 61 v1
//
//  Created by Marjo Salo on 28/04/2021.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var tags: String?
    @NSManaged public var registered: Date?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var id: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var company: String?
    @NSManaged public var age: Int16
    @NSManaged public var about: String?
    @NSManaged public var friends: NSSet?
    
    public var unwrappedId: String {
        id ?? "Unknown"
    }
    public var unwrappedAbout: String {
        about ?? "No description"
    }
    public var unwrappedAddress: String {
        address ?? "Unknown"
    }
    public var unwrappedCompany: String {
        company ?? "Unknown"
    }
    public var unwrappedEmail: String {
        email ?? "Unknown"
    }
    public var unwrappedName: String {
        name ?? "Unknown"
    }
    public var unwrappedTags: String {
        tags ?? "Unknown"
    }
    
    public var registrationDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY-MM-DD"
        formatter.dateStyle = .long
        return formatter.string(from: registered ?? Date())
    }
    
    public var friendsArray: [CDFriend] {
        let set = friends as? Set<CDFriend> ?? []
        return set.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CDUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CDFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CDFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CDUser : Identifiable {

}
