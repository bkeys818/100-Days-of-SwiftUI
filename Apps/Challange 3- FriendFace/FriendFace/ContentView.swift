//
//  ContentView.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/20/20.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        NavigationView {
            List {
                ForEach(self.users, id:\.id) { user in
                    ZStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.circle")
                                .font(Font.title.weight(.light))
                                .foregroundColor(.secondary)
                                .padding(.bottom, 2)
                            VStack(alignment: .leading) {
                                Text(user.name ?? "")
                                    .font(.headline)
                                Text("\(user.email ?? "")")
                                    .font(.caption)
                            }
                            Spacer()
                            if user.isActive {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 10, height: 10)
                            } else  {
                                Circle()
                                    .stroke(Color.green)
                                    .frame(width: 10, height: 10)
                            }
                        }
                        NavigationLink(destination: DetailView(user: user), label: { EmptyView() } )
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Friend Face")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
