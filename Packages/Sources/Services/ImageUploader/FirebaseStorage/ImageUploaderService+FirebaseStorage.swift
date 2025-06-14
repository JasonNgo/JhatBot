import FirebaseStorage
import Foundation

extension ImageUploaderService {

    /// A concrete implementation of `ImageUploaderService` using Firebase Storage.
    static public let firebaseStorage = Self(
        uploadImage: { data, path in
            let name = "\(path).jpg"
            let reference = Storage.storage().reference(withPath: name)

            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            let returnedMetadata = try await reference.putDataAsync(data, metadata: metadata)

            guard let returnedPath = returnedMetadata.path, URL(string: returnedPath) != nil else {
                throw URLError(.badURL)
            }

            return try await reference.downloadURL()
        }
    )

}
