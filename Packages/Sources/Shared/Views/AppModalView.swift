//
//  AppModalView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-06.
//

import SwiftUI

public struct AppModalView<T: Equatable, Content: View>: View {

    // MARK: - Properties

    @Binding private var showModal: T?
    private var content: Content

    // MARK: - Initializers

    public init(
        showModal: Binding<T?>,
        @ViewBuilder content: (T?) -> Content
    ) {
        self._showModal = showModal
        self.content = content(showModal.wrappedValue)
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            if let _ = self.showModal {
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
    public func showModal<T: Equatable>(_ showModal: Binding<T?>, @ViewBuilder content: (T?) -> some View) -> some View {
        self.overlay(
            AppModalView(showModal: showModal, content: { value in
                content(value)
            })
        )
    }
}

// MARK: - Previews

#Preview {
//    AppModalView()
}
