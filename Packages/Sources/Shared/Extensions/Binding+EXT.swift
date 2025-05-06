//
//  Binding+EXT.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import SwiftUI

extension Binding where Value == Bool {

    public init<T: Sendable>(ifNotNil alertTitle: Binding<T?>) {
        self.init {
            alertTitle.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                alertTitle.wrappedValue = nil
            }
        }
    }

}
