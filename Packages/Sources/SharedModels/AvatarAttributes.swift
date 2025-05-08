//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-06.
//

import Foundation

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

public struct AvatarDescriptionBuilder {
    public let characterOption: CharacterOption
    public let characterAction: CharacterAction
    public let characterLocation: CharacterLocation

    public init(
        characterOption: CharacterOption,
        characterAction: CharacterAction,
        characterLocation: CharacterLocation
    ) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }

    public init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }

    public var characterDescription: String {
        let prefix = characterOption.rawValue.first?.isVowel ?? false ? "An" : "A"
        return "\(prefix) \(characterOption.rawValue) that is \(characterAction.rawValue) in the \(characterLocation.rawValue)."
    }
}
