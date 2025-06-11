//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import SharedModels
import Foundation

extension AvatarService {

    static public let mock = Self(
        createAvatar: { _ in
            try await Task.sleep(for: .seconds(2))
        },
        getAvatar: { id in
            try await Task.sleep(for: .seconds(2))
            return AvatarModel.mock
        },
        getFeaturedAvatars: {
            try await Task.sleep(for: .seconds(2))

            let avatars = AvatarModel.mocks

            return avatars.shuffled().first(upTo: 5) ?? []
        },
        getPopularAvatars: {
            try await Task.sleep(for: .seconds(2))
            let avatars = AvatarModel.mocks
            return avatars
        },
        getAvatarsForCategory: { category in
            try await Task.sleep(for: .seconds(2))
            let avatars = AvatarModel.mocks
            return avatars.filter { $0.characterOption == category }
        },
        getAvatarsForAuthor: { authorId in
            try await Task.sleep(for: .seconds(2))
            let avatars = AvatarModel.mocks
            return avatars.filter { $0.authorID == authorId }
        }
    )

}
