//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-22.
//

import FirebaseFirestore
import SharedModels
import Foundation

public extension UserService {
    static let firestore = Self(
//        getUser: { userId in
//            try await Firestore.firestore().collection("users")
//                .document(userId)
//                .getDocument()
//                .data(as: UserModel.self)
//        },
        saveUser: { user in
            try Firestore.firestore().collection("users")
                .document(user.userId)
                .setData(from: user, merge: true)
        },
        deleteUser: { userId in
            Firestore.firestore().collection("users")
                .document(userId).delete()
        },
        updateUser: { userId, updates in
            Firestore.firestore().collection("users")
                .document(userId)
                .updateData(updates)
        },
        addUserListener: { userId, onListenerAttached in
            AsyncThrowingStream { continuation in
                let listener = Firestore.firestore().collection("users").document(userId)
                    .addSnapshotListener { snapshot, error in
                        guard error == nil else {
                            continuation.finish(throwing: error)
                            return
                        }

                        guard let snapshot = snapshot else {
                            continuation.finish(throwing: UserServiceError.noData)
                            return
                        }

                        do {
                            let items = try snapshot.data(as: UserModel.self)
                            continuation.yield(items)
                        } catch {
                            continuation.finish(throwing: error)
                        }
                    }

                let sendableListener = SendableListenerRegistration(listener)
                continuation.onTermination = { _ in
                    sendableListener.remove()
                }

                onListenerAttached(listener)
            }
        },
        removeUserListener: { listener in
            guard let firebaseListener = listener as? ListenerRegistration else { return }
            firebaseListener.remove()
        }
    )
}

// swiftlint:disable:next private_over_fileprivate
fileprivate struct SendableListenerRegistration: @unchecked Sendable {
    private let registration: ListenerRegistration

    init(_ registration: ListenerRegistration) {
        self.registration = registration
    }

   func remove() {
        registration.remove()
    }
}
