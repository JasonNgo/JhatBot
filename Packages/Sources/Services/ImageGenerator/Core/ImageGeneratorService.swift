import Foundation

public struct ImageGeneratorService: Sendable {
    public var generateImage: @Sendable (_ input: String) async throws -> Data
}
