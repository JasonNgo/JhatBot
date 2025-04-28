//
//  AppViewBuilder.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

public struct AppViewBuilder<AuthenticatedView: View, UnauthenticatedView: View>: View {

    // MARK: - Properties

    private(set) var isAuthenticated: Bool
    private var authenticatedContentView: () -> AuthenticatedView
    private var unauthenticatedContentView: () -> UnauthenticatedView

    // MARK: - Initializers

    public init(
        isAuthenticated: Bool,
        @ViewBuilder authenticatedContentView: @escaping () -> AuthenticatedView,
        @ViewBuilder unauthenticatedContentView: @escaping () -> UnauthenticatedView
    ) {
        self.isAuthenticated = isAuthenticated
        self.authenticatedContentView = authenticatedContentView
        self.unauthenticatedContentView = unauthenticatedContentView
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            if isAuthenticated {
                authenticatedContentView()
                    .transition(.move(edge: .trailing))
            } else {
                unauthenticatedContentView()
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: isAuthenticated)
    }

}

// MARK: - Previews

// swiftlint:disable:next private_over_fileprivate
fileprivate struct PreviewView: View {

    @State private var isAuthenticated = false

    var body: some View {
        AppViewBuilder(
            isAuthenticated: isAuthenticated,
            authenticatedContentView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Authenticated View")
                }
            },
            unauthenticatedContentView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Unauthenticated View")
                }
            }
        )
        .onTapGesture {
            isAuthenticated.toggle()
        }
    }

}

#Preview {
    PreviewView()
}
