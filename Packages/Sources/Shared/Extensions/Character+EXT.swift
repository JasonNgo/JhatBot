//
//  Character+EXT.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Foundation

extension Character {
    public var isVowel: Bool {
        let vowels: [Character] = ["A", "a", "E", "e", "I", "i", "O", "o", "U", "u"]

        return vowels.contains(self)
    }
}
