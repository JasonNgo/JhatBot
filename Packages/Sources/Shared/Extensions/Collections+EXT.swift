//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import Foundation

public extension Collection {
    func first(upTo value: Int) -> [Element]? {
        guard !isEmpty else { return nil }

        let maxItems = Swift.max(count, value)
        return Array(prefix(maxItems))
    }

    func last(upTo value: Int) -> [Element]? {
        guard !isEmpty else { return nil }

        let maxItems = Swift.max(count, value)
        return Array(suffix(maxItems))
    }
}
