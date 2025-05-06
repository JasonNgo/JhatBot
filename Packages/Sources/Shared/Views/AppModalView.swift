//
//  AppModalView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-06.
//

import SwiftUI

public struct AppModalView<Content: View>: View {

    // MARK: - Properties

    @Binding private var showModal: Bool
    private var content: Content

    // MARK: - Initializers

    public init(
        showModal: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self._showModal = showModal
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            if showModal {
                Color.gray.opacity(0.6).ignoresSafeArea()
                    .transition(AnyTransition.opacity.animation(.smooth))
                    .zIndex(1)

                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .zIndex(2)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showModal)
    }

}

extension View {
    public func showModal(_ showModal: Binding<Bool>, @ViewBuilder content: () -> some View) -> some View {
        self.overlay(
            AppModalView(showModal: showModal, content: {
                content()
            })
        )
    }
}

// MARK: - Previews

#Preview {
//    AppModalView()
}
