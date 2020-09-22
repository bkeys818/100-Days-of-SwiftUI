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
                .onAppear(perform: loadData)
        }
    }
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("Invalid URL")
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                fatalError(error?.localizedDescription ?? "Unknown Error")
            }
            if let data = data {
                let decoder = JSONDecoder()
                let RFC3339DateFormatter = DateFormatter()
                RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
                RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                RFC3339DateFormatter.timeZone = TimeZone.current
                decoder.dateDecodingStrategy = .formatted(RFC3339DateFormatter)
                do {
                    let users = try decoder.decode([User].self, from: data)
                    DispatchQueue.main.async {
                        self.appData.users = users
                    }
                } catch DecodingError.dataCorrupted(let context) {
                    fatalError("Error decoding Title\n\(context.debugDescription)")
                } catch DecodingError.keyNotFound(let key, let context) {
                    fatalError("Error decoding Title\n\(key.stringValue) was not found, \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    fatalError("Error decoding Title\n\(type) was expected, \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    fatalError("Error decoding Title\nNo value was found for \(type), \(context.debugDescription)")
                } catch {
                    fatalError("Error decoding Title\nUnknown Error")
                }
            } else {
                fatalError("URL session retrieved no data")
            }
        }.resume()
    }
}
