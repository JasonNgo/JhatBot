import AppFeature
import SwiftUI

@main
struct JhatBotApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.dependencies.imageGenerator)
                .environment(delegate.dependencies.imageUploader)
                .environment(delegate.dependencies.avatarRepository)
                .environment(delegate.dependencies.userStore)
                .environment(delegate.dependencies.authStore)
        }
    }

}
