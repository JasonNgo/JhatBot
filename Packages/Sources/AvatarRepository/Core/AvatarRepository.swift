//
//  AvatarRepository.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import SharedModels
import ImageUploader
import Foundation
import Observation

@MainActor
@Observable
final public class AvatarRepository {

    // MARK: - Dependencies

    private let avatarService: AvatarService
    private let imageUploader: ImageUploader

    // MARK: - Initializers

    public init(
        avatarService: AvatarService,
        imageUploader: ImageUploader
    ) {
        self.avatarService = avatarService
        self.imageUploader = imageUploader
    }

    // MARK: - CRUD

    public func createAvatar(avatar: AvatarModel, imageData: Data) async throws {
        // upload the image
        let path = "avatars/\(avatar.avatarID)"
        let imageURL = try await imageUploader.uploadImage(imageData, path)

        // update the avatar model with the new image url
        var avatar = avatar
        avatar.updateProfileImageURL(imageURL.absoluteString)

        // create the avatar
        try await avatarService.createAvatar(avatar)
    }

    // MARK: Fetching

    public func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await avatarService.getFeaturedAvatars()
    }

    public func getPopularAvatars() async throws -> [AvatarModel] {
        try await avatarService.getPopularAvatars()
    }

}
