//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Benjamin Keys on 6/20/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var username = ""
    @State var email = ""
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section{
                Button("Create Account") {
                    print("Creating Account")
                }
            }
            .disabled(username.isEmpty || email.isEmpty)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
