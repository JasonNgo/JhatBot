//
//  MainViewBuilder.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

struct MainViewBuilder<AuthenticatedView: View, UnauthenticatedView: View>: View {

    var isAuthenticated: Bool

    @ViewBuilder var authenticatedContentView: AuthenticatedView
    @ViewBuilder var unauthenticatedContentView: UnauthenticatedView

    var body: some View {
        ZStack {
            if isAuthenticated {
                authenticatedContentView
                    .transition(.move(edge: .trailing))
            } else {
                unauthenticatedContentView
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: isAuthenticated)
    }

}

// swiftlint:disable:next private_over_fileprivate
fileprivate struct PreviewView: View {

    @State private var isAuthenticated = false

    var body: some View {
        MainViewBuilder(
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
