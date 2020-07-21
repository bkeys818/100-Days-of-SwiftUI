//
//  Adding Codable conformance for @Published properties.swift
//  CupcakeCorner
//
//  Created by Benjamin Keys on 6/20/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import Foundation

class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    @Published var name = "Paul Hudson"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // This data should have a container where the keys match whatever keys we have inside our CodingKeys enum.
        name = try container.decode(String.self, forKey: .name) // Read values directly from that container. Very safe in two ways: It's made clear the type is string, and the case from CodingKeys enum is used rather than a string, so there’s no chance of typos.
    }
    
    func encode(to encoder: Encoder) throws {
        // Handed an Encoder instance to write to.
        var container = encoder.container(keyedBy: CodingKeys.self) // Ask it to make a container using our CodingKeys enum for keys.
        try container.encode(name, forKey: .name) // Write our values attached to each key.
    }
}
