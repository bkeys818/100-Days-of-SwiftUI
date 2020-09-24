//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/22/20.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable, Identifiable  {
    public enum ClassCodingErrors: Error {
        case invalidUUID, invalidDate
    }
    
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
//    private func unwrap<T>(_ optional: T?) -> T {
//        if let unwapped = optional {
//            return unwapped
//        } else if optional == nil {
//            fatalError("Type \(type(of: optional)) contains no value")
//        }
//        fatalError("\(optional!) is not an optional")
//    }
    
    required public convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
                fatalError("Failed to decode User")
            }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let idString = try? container.decode(String.self, forKey: .id) {
            if let id = UUID(uuidString: idString) {
                self.id = id
            } else { throw ClassCodingErrors.invalidUUID }
        } else {
            fatalError("No UUID Provided")
        }
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = NSSet(array: try container.decode([Friend].self, forKey: .friends))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id!.uuidString, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(tags, forKey: .tags)
        try container.encode(friendArray, forKey: .friends)
    }
    
    var friendArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted {
            $0.id!.uuidString < $1.id!.uuidString
        }
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
