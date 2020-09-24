//
//  Friend+CoreDataClass.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/22/20.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, name
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Friend", in: managedObjectContext) else {
                fatalError("Failed to decode Friend")
            }
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let id = UUID(uuidString: (try? container.decode(String.self, forKey: .id)) ?? "") else {
            fatalError()
        }
        self.id = id
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id!.uuidString, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
