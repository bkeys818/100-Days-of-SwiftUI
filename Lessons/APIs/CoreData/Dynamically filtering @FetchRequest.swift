//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Benjamin Keys on 6/29/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    // Other NSPredicate options
        // "universe == 'Star Wars'"
        // "universe == %@", "Star Wars"
        // "name < %@", "F"
        // "universe in %@", ["Aliens", "Firefly", "Star Trek"]
        // "name BEGINSWITH %@", "E"
        // "name BEGINSWITH[c] %@", "e"     -- not case sensitive
        // "name CONTAINS %@", "E"
        // "not name CONTAINS %@", "E"      -- inverse statement
        // "and" comninds multiple predicates

    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
