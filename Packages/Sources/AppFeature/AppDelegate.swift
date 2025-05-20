//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-08.
//

import Firebase
import SwiftUI

public class AppDelegate: NSObject, UIApplicationDelegate {

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()

        return true
    }

}
