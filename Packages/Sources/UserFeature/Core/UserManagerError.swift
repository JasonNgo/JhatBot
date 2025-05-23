//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-23.
//

import Foundation

public enum UserManagerError: LocalizedError {
    case noData
    case noUserId

    public var errorDescription: String? {
        switch self {
        case .noData:
            return "No data found for user."
        case .noUserId:
            return "No user id found"
        }
    }
}
