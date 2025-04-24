//
//  AppState.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI
import Observation

@Observable
final class AppState {

    private(set) var isAuthenticated: Bool

    init(
        isAuthenticated: Bool = UserDefaults.standard.isAuthenticated
    ) {
        self.isAuthenticated = isAuthenticated
    }

    func updateAuthenticationState(_ state: Bool) {
        UserDefaults.standard.isAuthenticated = state
        self.isAuthenticated = state
    }

}
