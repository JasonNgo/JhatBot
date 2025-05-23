//
//  JhatBotApp.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI
import AppFeature

@main
struct JhatBotApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            EnvironmentBuilderView {
                AppView()
            }
        }
    }

}

struct EnvironmentBuilderView<Content: View>: View {

    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .environment(AuthManager(service: .firebase))
            .environment(UserManager(service: .firestore))
    }


}
