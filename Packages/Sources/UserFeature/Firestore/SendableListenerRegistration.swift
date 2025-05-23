//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-23.
//

import FirebaseFirestore
import Foundation

struct SendableListenerRegistration: @unchecked Sendable {
     private let registration: ListenerRegistration

     init(_ registration: ListenerRegistration) {
         self.registration = registration
     }

    func remove() {
         registration.remove()
     }
 }
