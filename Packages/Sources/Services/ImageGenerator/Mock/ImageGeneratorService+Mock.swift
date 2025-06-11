import Shared
import Foundation

extension ImageGeneratorService {

    /// A mock implementation of `ImageGeneratorService`
    public static let mock = Self(
        generateImage: { input in
            try await Task.sleep(for: .seconds(3))

            guard let url = URL(string: Constants.randomImageURLString) else {
                throw URLError(.badURL)
            }

            let data = try Data(contentsOf: url)

            return data
        }
    )

    /// A no-op implementation of `ImageGeneratorService`
    public static let noop = Self(
        generateImage: { _ in
            fatalError("No-op implementation of `ImageGeneratorService.generateImage`")
        }
    )

}
