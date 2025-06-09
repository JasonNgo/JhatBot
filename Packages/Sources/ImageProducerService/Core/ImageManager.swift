//
//  ImageManager.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import Foundation

@MainActor
@Observable
public class ImageManager {

    // MARK: - Properties

    // MARK: - Dependencies

    private let service: ImageProducer

    // MARK: - Initializers

    public init(service: ImageProducer) {
        self.service = service
    }

    public func generateImage(input: String) async throws -> Data {
        try await service.generateImage(input)
    }

}
