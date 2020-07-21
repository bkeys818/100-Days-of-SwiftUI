//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Benjamin Keys on 7/19/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
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
    @NSManaged public var friendOf: User?
    
    public var nameUnwrapped: String {
            return name ?? "Unknown"
    }
}
