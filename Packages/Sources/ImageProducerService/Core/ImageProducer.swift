//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-27.
//

import Foundation

public struct ImageProducer: Sendable {

    public var generateImage: @Sendable (_ input: String) async throws -> Data

}

public enum ImageProducerError: Error {
    case unableToGenerateImage
}
