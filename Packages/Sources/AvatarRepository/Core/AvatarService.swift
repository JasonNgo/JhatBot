//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import SharedModels
import Foundation

public struct AvatarService: Sendable {
    public var createAvatar: @Sendable (_ avatar: AvatarModel) async throws -> Void

    public var getFeaturedAvatars: @Sendable () async throws -> [AvatarModel]
    public var getPopularAvatars: @Sendable () async throws -> [AvatarModel]
}
