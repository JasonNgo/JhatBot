//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Shared
import Foundation

public struct AvatarModel: Hashable, Sendable {
    public let avatarID: String
    public let name: String?
    public let characterOption: CharacterOption?
    public let characterAction: CharacterAction?
    public let characterLocation: CharacterLocation?
    public let profileImageURL: String?
    public let authorID: String?
    public let dateCreated: Date?

    public var characterDescription: String {
        AvatarDescriptionBuilder(avatar: self).characterDescription
    }

    public init(
        avatarID: String,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageURL: String? = nil,
        authorID: String? = nil,
        dateCreated: Date? = nil
    ) {
        self.avatarID = avatarID
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageURL = profileImageURL
        self.authorID = authorID
        self.dateCreated = dateCreated
    }
}

extension AvatarModel {
    public static var mocks: [AvatarModel] {
        [
            AvatarModel(
                avatarID: UUID().uuidString,
                name: "Alpha",
                characterOption: .man,
                characterAction: .eating,
                characterLocation: .park,
                profileImageURL: Constants.randomImageURLString,
                authorID: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarID: UUID().uuidString,
                name: "Beta",
                characterOption: .woman,
                characterAction: .relaxing,
                characterLocation: .mall,
                profileImageURL: Constants.randomImageURLString,
                authorID: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarID: UUID().uuidString,
                name: "Gamma",
                characterOption: .alien,
                characterAction: .smiling,
                characterLocation: .desert,
                profileImageURL: Constants.randomImageURLString,
                authorID: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarID: UUID().uuidString,
                name: "Delta",
                characterOption: .dog,
                characterAction: .drinking,
                characterLocation: .forest,
                profileImageURL: Constants.randomImageURLString,
                authorID: UUID().uuidString,
                dateCreated: .now
            )
        ]
    }

    public static var mock: AvatarModel { mocks[0] }
}

public enum CharacterOption: String, CaseIterable, Hashable, Sendable {
    case man, woman, alien, dog, cat

    public static var `default`: Self { .man }
}

public enum CharacterAction: String, CaseIterable, Hashable, Sendable {
    case smiling, sitting, eating, drinking, walking, shopping, studying, working, relaxing, fighting, crying

    public static var `default`: Self { .smiling }
}

public enum CharacterLocation: String, CaseIterable, Hashable, Sendable {
    case park, mall, museum, city, desert, forest, space

    public static var `default`: Self { .park }
}
