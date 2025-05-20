//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-20.
//

import Foundation

public enum AuthServiceError: LocalizedError {
    case userNotFound

    public var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "Current authorized user not found."
        }
    }
}
