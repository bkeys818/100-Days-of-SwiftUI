//
//  IsActive.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/21/20.
//

import SwiftUI

struct IsActive: View {
    var active: Bool
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        if active {
        Circle()
            .fill(Color.green)
            .frame(width: 10, height: 10)
            .overlay(
                Circle()
                    .stroke(Color.green)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        Animation.easeInOut(duration: 1)
                            .repeatForever(autoreverses: false)
                    )
            )
            .onAppear(perform: {
                self.animationAmount = 2
            })
        } else  {
            Circle()
                .stroke(Color.green)
                .frame(width: 10, height: 10)
        }
    }
}

struct IsActive_Previews: PreviewProvider {
    static var previews: some View {
        IsActive(active: true)
    }
}
