//
//  DetailView.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/21/20.
//

import SwiftUI

struct DetailView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    var user: User

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                
                Section {
                    HStack(alignment: .center) {
                        Image(systemName: "person.circle")
                            .font(Font.system(size: 72).weight(.thin))
                        VStack(alignment: .leading) {
                            Text(user.name ?? "")
                                .font(.title)
                                .fontWeight(.medium)
                            Text("\(user.age) years old")
                        }
                        Spacer()
                    }
                }
                
                
                Section(header: Text("Bio").sectionHeader()) {
                    Text(user.about?.trimmingCharacters(in: CharacterSet.newlines) ?? "")
                        .font(.callout)
                }
                
                
                Section(header: Text("Information").sectionHeader()) {
                    Text("Company: \(user.company ?? "")")
                    Text("Email: \(user.email ?? "")")
                    Text("Address: \(user.address ?? "")")
                }
                
                
                Section(header: Text("Friends").sectionHeader()) {
                    ForEach(self.users, id: \.id) { friend in
                        NavigationLink(destination: DetailView(user: self.users.first(where: { $0.id == friend.id })!)) {
                            HStack {
                                Image(systemName: "person.circle")
                                Text(friend.name ?? "")
                            }
                            .foregroundColor(.primary)
                        }
                        .buttonStyle(FriendLink())
                    }
                }
                
                
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 18)
            .navigationBarTitle(Text(user.name ?? ""), displayMode: .inline)
        }
    }
}
