//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/23/20.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var parent: User?

}
