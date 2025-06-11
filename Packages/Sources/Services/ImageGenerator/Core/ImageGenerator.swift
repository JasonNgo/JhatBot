import Foundation
import Observation

@MainActor
@Observable
public class ImageGenerator {

    // MARK: - Dependencies

    private let service: ImageGeneratorService

    // MARK: - Initializers

    public init(service: ImageGeneratorService) {
        self.service = service
    }

    // MARK:

    public func generateImage(prompt: String) async throws -> Data {
        try await service.generateImage(prompt)
    }

}
