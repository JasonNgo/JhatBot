//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Foundation

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
