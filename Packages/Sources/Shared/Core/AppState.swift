//
//  AppState.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI
import Observation

@Observable
final public class AppState {

    public private(set) var isAuthenticated: Bool

    public init(
        isAuthenticated: Bool = UserDefaults.standard.isAuthenticated
    ) {
        self.isAuthenticated = isAuthenticated
    }

    public func updateAuthenticationState(_ state: Bool) {
        UserDefaults.standard.isAuthenticated = state
        self.isAuthenticated = state
    }

}
