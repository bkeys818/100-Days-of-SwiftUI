//
//  ContentView.swift
//  FriendFace
//
//  Created by Benjamin Keys on 7/19/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors:[]) var users: FetchedResults<User>
    var body: some View {
        NavigationView {
            List {
                Text("Hello, World!")
            }
            .navigationBarTitle(Text("Friend Face"))
        }
    }
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("URL is broken")
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>) {
                    DispatchQueue.main.async {
                        self.users = decodedResponse.users
                    }
                    return
                }
            }
            fatalError("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
