//
//  UserDefaults+EXT.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Foundation

extension UserDefaults {
    private struct Keys {
        static let isAuthenticated = "isAuthenticated"
    }

    var isAuthenticated: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.isAuthenticated) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.isAuthenticated) }
    }
}

extension UserDefaults {

    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }

}
