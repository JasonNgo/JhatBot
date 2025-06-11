import Foundation

public enum UserStoreError: LocalizedError {
    case noData
    case noUserId

    public var errorDescription: String? {
        switch self {
        case .noData:
            return "No data found for user."
        case .noUserId:
            return "No user id found"
        }
    }
}
