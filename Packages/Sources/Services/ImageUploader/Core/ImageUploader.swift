import Foundation
import Observation

@MainActor
@Observable
public class ImageUploader {

    // MARK: - Dependencies

    private let service: ImageUploaderService

    // MARK: - Initializers

    public init(service: ImageUploaderService) {
        self.service = service
    }

    /// Upload the given data at the specified path.
    /// Note:
    ///   - This function expects data to be in a valid jpeg format
    public func uploadImage(data: Data, path: String) async throws -> URL {
        try await service.uploadImage(data, path)
    }

}
