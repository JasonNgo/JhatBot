//
//  View+EXT.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

extension View {
    @available(iOS 18.0, *)
    public func trackScrollPosition(
        _ position: Binding<ScrollPosition>,
        anchor: UnitPoint? = nil
    ) -> some View {
        self
            .scrollTargetLayout()
            .scrollPosition(position, anchor: anchor)
    }

    public func trackScrollPosition(
        _ id: Binding<(some Hashable)?>,
        anchor: UnitPoint? = nil
    ) -> some View {
        self
            .scrollTargetLayout()
            .scrollPosition(id: id, anchor: anchor)
    }
}

extension View {
    public func withCallToActionStyle() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.accentColor, in: .rect(cornerRadius: 16))
    }

    public func removeListRowFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }

    /// Used to fix glitchy behaviour when scrolling items in a list
    public func wrapForListStability() -> some View {
        ZStack { self }
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

extension View {

    @ViewBuilder
    public func ifSatisfiesCondition(_ condition: Bool, transform: (Self) -> some View) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

}
