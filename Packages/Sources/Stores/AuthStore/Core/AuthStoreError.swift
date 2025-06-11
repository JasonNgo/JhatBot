import Foundation

public enum AuthStoreError: LocalizedError {
    case notSignedIn

    public var errorDescription: String? {
        switch self {
        case .notSignedIn:
            return "Unable to find signed in user."
        }
    }
}
