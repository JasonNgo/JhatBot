//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-20.
//

import Foundation

public enum AuthManagerError: LocalizedError {
    case notSignedIn

    public var errorDescription: String? {
        switch self {
        case .notSignedIn:
            return "Unable to find signed in user."
        }
    }
}
