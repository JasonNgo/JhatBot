import Foundation
import SwiftData

extension AvatarPersistence {

    // swiftlint:disable:next force_try
    static private let container = try! ModelContainer(for: AvatarEntity.self)

    public static let swiftData = Self(
        addRecentAvatar: { avatar in
            let entity = AvatarEntity(from: avatar)

            try await MainActor.run {
                container.mainContext.insert(entity)
                try container.mainContext.save()
            }
        },
        getRecentAvatars: {
            let descriptor = FetchDescriptor<AvatarEntity>(sortBy: [
                SortDescriptor(\.dateAdded, order: .reverse)
            ])

            return try await MainActor.run {
                let entities = try container.mainContext.fetch(descriptor)
                return entities.map { $0.toModel() }
            }
        }
    )

}
