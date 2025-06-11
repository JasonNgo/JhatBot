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

    private let service: AvatarService
    private let persistence: AvatarPersistence
    private let imageUploader: ImageUploader

    // MARK: - Initializers

    public init(
        service: AvatarService,
        persistence: AvatarPersistence,
        imageUploader: ImageUploader
    ) {
        self.service = service
        self.persistence = persistence
        self.imageUploader = imageUploader
    }

    // MARK: - CRUD

    public func createAvatar(avatar: AvatarModel, imageData: Data) async throws {
        // upload the image
        let path = "avatars/\(avatar.avatarID)"
        let imageURL = try await imageUploader.uploadImage(data: imageData, path: path)

        // update the avatar model with the new image url
        var avatar = avatar
        avatar.updateProfileImageURL(imageURL.absoluteString)

        // create the avatar
        try await service.createAvatar(avatar)
    }

    public func getAvatar(id: String) async throws -> AvatarModel {
        try await service.getAvatar(id)
    }

    public func addRecentAvatar(_ avatar: AvatarModel) async throws {
        try await persistence.addRecentAvatar(avatar)
    }

    // MARK: Fetching

    public func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await service.getFeaturedAvatars()
    }

    public func getPopularAvatars() async throws -> [AvatarModel] {
        try await service.getPopularAvatars()
    }

    public func getRecentAvatars() async throws -> [AvatarModel] {
        try await persistence.getRecentAvatars()
    }

    public func getAvatarsForCategory(_ category: CharacterOption) async throws -> [AvatarModel] {
        try await service.getAvatarsForCategory(category)
    }

    public func getAvatarsForAuthor(_ authorId: String) async throws -> [AvatarModel] {
        try await service.getAvatarsForAuthor(authorId)
    }

}
