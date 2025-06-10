//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import Foundation
import Observation

@MainActor
@Observable
public class ImageGenerator {

    private let service: ImageGeneratorService

    public init(service: ImageGeneratorService) {
        self.service = service
    }

    public func generateImage(prompt: String) async throws -> Data {
        try await service.generateImage(prompt)
    }
}
