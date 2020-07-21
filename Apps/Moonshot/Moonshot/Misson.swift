//
//  Misson.swift
//  Moonshot
//
//  Created by Benjamin Keys on 5/16/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import Foundation

struct Mission : Codable, Identifiable {
    struct CrewRole : Codable {
        let name : String
        let role : String
    }
    
    let id : Int
    let launchDate: Date?
    let crew : [CrewRole]
    let description : String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var crewNameList: String {
        var list = "\(crew[0].name.first!.uppercased())\(crew[0].name.dropFirst())"
        for i in (1...crew.count) {
            let crewName: String = "\(self.crew[i-1].name.first!.uppercased())\(self.crew[i-1].name.dropFirst())"
            list = list + ", " + crewName
        }
        return list
    }
}
