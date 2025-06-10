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
            AppView()
                .environment(delegate.dependencies.imageGenerator)
                .environment(delegate.dependencies.imageUploader)
                .environment(delegate.dependencies.avatarRepository)
                .environment(delegate.dependencies.userManager)
                .environment(delegate.dependencies.authManager)
        }
    }

}
