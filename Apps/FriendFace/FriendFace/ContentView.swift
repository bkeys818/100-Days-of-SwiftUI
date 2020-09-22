//
//  ContentView.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/20/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData: AppData
    @State var showingDetailView = false
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        NavigationView {
            List {
                ForEach(self.appData.users, id: \.id) { user in
                    ZStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.circle")
                                .font(Font.title.weight(.light))
                                .foregroundColor(.secondary)
                                .padding(.bottom, 2)
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                Text("\(user.email)")
                                    .font(.caption)
                            }
                            Spacer()
                            IsActive(active: user.isActive)
                        }
                        NavigationLink(destination: DetailView(user: user), isActive: $showingDetailView, label: { EmptyView() } )
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Friend Face")
        }
        .onAppear(perform: loadData)
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
                    self.appData.users = try decoder.decode([User].self, from: data)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
