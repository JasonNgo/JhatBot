//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-11.
//

import SharedModels
import Foundation

public struct AvatarPersistence: Sendable {
    public var addRecentAvatar: @Sendable (_ avatar: AvatarModel) async throws -> Void
    public var getRecentAvatars: @Sendable () async throws -> [AvatarModel]
}
