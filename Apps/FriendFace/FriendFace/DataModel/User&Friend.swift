//
//  User.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/20/20.
//

import Foundation

class User: Codable, Identifiable, ObservableObject {
    public enum ClassCodingErrors: Error {
        case invalidUUID, invalidDate
    }
    
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let idString = try container.decode(String.self, forKey: .id)
        if let id = UUID(uuidString: idString) {
            self.id = id
        } else {
            throw ClassCodingErrors.invalidUUID
        }
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(tags, forKey: .tags)
        try container.encode(friends, forKey: .friends)
    }
    
    init() {
        self.id = UUID()
        self.isActive = false
        self.name = ""
        self.age = 0
        self.company = ""
        self.email = ""
        self.address = ""
        self.about = ""
        self.registered = Date()
        self.tags = [String]()
        self.friends = [Friend]()
    }
}

class Friend: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    var id: UUID
    var name: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let idString = try container.decode(String.self, forKey: .id)
        if let id = UUID(uuidString: idString) {
            self.id = id
        } else {
            throw User.ClassCodingErrors.invalidUUID
        }
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}


extension User {
    static var exampleUser: User {
        let JSON = """
        {
            "id": "eccdf4b8-c9f6-4eeb-8832-28027eb70155",
            "isActive": true,
            "name": "Gale Dyer",
            "age": 28,
            "company": "Cemention",
            "email": "galedyer@cemention.com",
            "address": "652 Gatling Place, Kieler, Arizona, 1705",
            "about": "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.\r\n",
            "registered": "2014-07-05T04:25:04-01:00",
            "tags": [
                "irure",
                "labore",
                "et",
                "sint",
                "velit",
                "mollit",
                "et"
            ],
            "friends": [
                {
                    "id": "1c18ccf0-2647-497b-b7b4-119f982e6292",
                    "name": "Daisy Bond"
                },
                {
                    "id": "a1ef63f3-0eab-49a8-a13a-e538f6d1c4f9",
                    "name": "Tanya Roberson"
                }
            ]
        }
        """
        if let data = JSON.data(using: .utf8) {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                return user
            } else {
                fatalError()
            }
        } else {
            fatalError()
        }
    }
}
