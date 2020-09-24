//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/20/20.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    let viewContext = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext.container.viewContext)
        }
    }
}
