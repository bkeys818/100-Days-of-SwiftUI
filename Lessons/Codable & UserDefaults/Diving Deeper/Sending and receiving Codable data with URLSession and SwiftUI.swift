//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Benjamin Keys on 6/20/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
    .onAppear(perform: loadData)
    }
    
    func loadData() {
        // Create URL.
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid ULR")
            return
        }
        
        // Wrapping URLRequest (to configure how it should be accessed).
        let request = URLRequest(url: url)
        
        // Create and start a networking task from that URL request.
        URLSession.shared.dataTask(with: request) { data, response, error in
            // We want to fetch the data and decode it from json in a background thread, and then, to avoid any potential problems, update the property on the main thread. "DispatchQueue.main.async()" is the particular iOS way to sending work to the main thread. It takes a closure of work to perform, and sends it off to the main thread for execution. What’s actually happening is that it’s added to a queue – a big line of work that’s waiting for execution. The “async” part means our own background work won’t wait for the closure to be run; we just add it to the queue and carry on working in the background.
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // This closure will only be entered if the data is good
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fatch failed: \(error?.localizedDescription ?? "Unkown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
