//
//  MainView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

struct MainView: View {

    @AppStorage("isAuthenticated")
    var isAuthenticated = false

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

#Preview("MainView - Authenticated") {
    MainView(isAuthenticated: true)
}

#Preview("MainView - Unauthenticated") {
    MainView(isAuthenticated: false)
}
