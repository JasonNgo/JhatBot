import Foundation

extension ImageGeneratorService {

    /// A mock implementation of `ImageGeneratorService`
    public static let mock = Self(
        generateImage: { input in
            try await Task.sleep(for: .seconds(3))
            let marker = "MOCK_IMAGE".data(using: .utf8)!
            let inputData = input.data(using: .utf8)!
            return marker + inputData
        }
    )

    /// A no-op implementation of `ImageGeneratorService`
    public static let noop = Self(
        generateImage: { _ in
            fatalError("No-op implementation of `ImageGeneratorService.generateImage`")
        }
    )

}
