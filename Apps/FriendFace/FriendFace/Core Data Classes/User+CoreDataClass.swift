//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by Benjamin Keys on 7/19/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    enum CodingKeys: String, CodingKey {
        case about, age, address, company, email, id, isActive, name, registered, tags ,friends
    }
    
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.role = try container.decodeIfPresent(String.self, forKey: .role)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(username, forKey: .username)
        try container.encode(role, forKey: .role)
    }
}
