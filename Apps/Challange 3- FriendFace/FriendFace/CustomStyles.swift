//
//  TextStyles.swift
//  FriendFace
//
//  Created by Benjamin Keys on 9/21/20.
//

import SwiftUI

struct SectionHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 18).weight(.medium))
            .foregroundColor(.secondary)
            .padding(.top, 6)
            .padding(.leading, 1)
            .textCase(.uppercase)
    }
}

extension View {
    func sectionHeader() -> some View {
        self.modifier(SectionHeader())
    }
}

struct FriendLink: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .accentColor)
            .padding(.vertical, 6)
            .padding(.horizontal, 9)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.secondary)
        )
    }
}
