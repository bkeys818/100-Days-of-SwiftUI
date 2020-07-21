//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Benjamin Keys on 7/19/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var about: String?
    @NSManaged public var age: Int16
    @NSManaged public var address: String?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: NSSet?
    
    public var emailUnwrapped: String {
        return email ?? "Unknown"
    }
    public var nameUnwrapped: String {
        return name ?? "Unknown"
    }
    public var tagsUnwrapped: [String] {
        return tags ?? []
    }
    public var friendsArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted {
            $0.nameUnwrapped < $1.nameUnwrapped
        }
    }
}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: Friend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: Friend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}
