//
//  ContentView.swift
//  InstaFilter
//
//  Created by Benjamin Keys on 9/24/20.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New Value is \(blurAmount)")
        }
    }
    
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New vlaue is \(self.blurAmount)")
            }
        )
        
        Text("Hello, world!")
        .blur(radius: blurAmount)
        Slider(value: blur, in: 0...10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
