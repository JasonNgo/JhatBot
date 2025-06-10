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
import ImageGenerator
import ImageUploader

import Firebase
import SwiftUI

public class AppDelegate: NSObject, UIApplicationDelegate {

    public var dependencies: Dependencies!

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()
        dependencies = Dependencies()

        return true
    }

}

@MainActor
public struct Dependencies {

    public let imageGenerator: ImageGenerator
    public let imageUploader: ImageUploader

    public let authManager: AuthManager
    public let userManager: UserManager
    public let avatarRepository: AvatarRepository

    public init(

    ) {
        self.imageGenerator = ImageGenerator(service: .mock)
        self.imageUploader = ImageUploader(service: .mock)

        self.authManager = AuthManager(service: .firebase)
        self.userManager = UserManager(service: .firestore, local: .fileManager)
        self.avatarRepository = AvatarRepository(service: .mock, imageUploader: imageUploader)
    }
}
