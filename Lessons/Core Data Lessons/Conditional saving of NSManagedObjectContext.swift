//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Benjamin Keys on 6/29/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var year: Int16
    @NSManaged public var attribute: String?
    @NSManaged public var title: String?
    
    public var titleWrapped: String {
        return title ?? "Unknown title"
    }
    public var authorWrapped: String {
        return title ?? "Unknown author"
    }

}
