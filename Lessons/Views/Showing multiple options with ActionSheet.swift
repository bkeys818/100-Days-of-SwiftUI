//
//  ContentView.swift
//  InstaFilter
//
//  Created by Benjamin Keys on 9/24/20.
//

import SwiftUI

struct ContentView: View {
    @State private var showingActionSheet = false
    @State private var backgorundColor = Color.white
    
    var body: some View {
        Text("Hello, world!")
            .frame(width: 300, height: 300)
            .background(backgorundColor)
            .onTapGesture{
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change background"),
                            message: Text("Select a new color"),
                            buttons: [
                                .default(Text("Red")) { self.backgorundColor = .red },
                                .default(Text("Green")) { self.backgorundColor = .green },
                                .default(Text("Blue")) { self.backgorundColor = .blue },
                                .cancel()
                            ])
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
