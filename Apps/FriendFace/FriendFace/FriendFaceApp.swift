//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/20/20.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    var appData = AppData()
        
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appData)
        }
    }
}
