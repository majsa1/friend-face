//
//  User+CoreDataProperties.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var isActive: Bool
    @NSManaged public var registered: Date?
    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var friends: NSSet?
    @NSManaged public var tags: NSSet? // keeps the possibility to treat tags as separate items; otherwise optional String
    
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
    
    var registrationDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY-MM-DD"
        formatter.dateStyle = .long
        return formatter.string(from: registered ?? Date())
    }
    
    public var tagString: String {
        let set = tags as? Set<Tag> ?? []
        var array = [String]()
        for tag in set {
            array.append(tag.unwrappedTag)
            array.sort()
        }
        return array.joined(separator: ", ")
    }
    
    public var friendsArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension User {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension User : Identifiable {

}
