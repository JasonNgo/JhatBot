//
//  View+EXT.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

extension View {
    public func withCallToActionStyle() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.accentColor, in: .rect(cornerRadius: 16))
    }
}

extension View {
    public func withTappableBackground(
        contentShape: some Shape = .rect,
        onTap: @escaping () -> Void
    ) -> some View {
        self
            .contentShape(contentShape)
            .onTapGesture {
                onTap()
            }
    }
}
