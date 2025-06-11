import Foundation

public struct ImageUploaderService: Sendable {

    /// Upload the given data at the specified path.
    /// Note:
    ///   - This function expects data to be in a valid jpeg format
    public var uploadImage: @Sendable (_ data: Data, _ path: String) async throws -> URL

}
