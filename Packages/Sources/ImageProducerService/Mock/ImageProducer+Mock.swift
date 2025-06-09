//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import Foundation

public extension ImageProducer {
    static let mock = Self(
        generateImage: { input in
            try await Task.sleep(for: .seconds(3))
            let marker = "MOCK_IMAGE".data(using: .utf8)!
            let inputData = input.data(using: .utf8)!
            return marker + inputData
        }
    )
}
