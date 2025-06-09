//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-08.
//

import Shared
import SharedModels
import AuthenticationFeature
import AuthService
import UserFeature
import AvatarRepository

import Firebase
import SwiftUI

public class AppDelegate: NSObject, UIApplicationDelegate {

    public var dependencies: Dependencies!

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        dependencies = Dependencies()
        FirebaseApp.configure()

        return true
    }

}

@MainActor
public struct Dependencies {
    public let authManager: AuthManager
    public let userManager: UserManager
    public let avatarRepository: AvatarRepository

    public init(
        authManager: AuthManager = .init(service: .firebase),
        userManager: UserManager = .init(service: .firestore, local: .fileManager),
        avatarRepository: AvatarRepository = .init(avatarService: .firebase, imageUploader: .firebaseStorage)
    ) {
        self.authManager = authManager
        self.userManager = userManager
        self.avatarRepository = avatarRepository
    }
}
