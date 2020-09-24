//
//  UserData.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/21/20.
//

import Foundation

class AppData: ObservableObject {
    @Published var users = [User]()
}
