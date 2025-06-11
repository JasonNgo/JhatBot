import Foundation

extension ImageUploaderService {

    /// A mock implementation of `ImageUploaderService`
    static public let mock = Self(
        uploadImage: { data, path in
            try await Task.sleep(for: .seconds(2))

            return URL(string: "")!
        }
    )

    /// A no-op implementation of `ImageUploaderService`
    static public let noop = Self(
        uploadImage: {
            fatalError("No-op implementation of `ImageUploaderService.uploadImage`")
        }
    )

}
