//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-11.
//

import SharedModels
import Foundation

extension AvatarPersistence {
    public static let mock = Self(
        addRecentAvatar: { _ in

        },
        getRecentAvatars: {
            return AvatarModel.mocks.shuffled()
        }
    )
}
