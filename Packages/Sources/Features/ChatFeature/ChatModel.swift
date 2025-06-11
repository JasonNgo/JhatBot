//
//  ChatModel.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Foundation

public struct ChatModel: Hashable {
    public let id: String
    public let userId: String
    public let avatarId: String
    public let dateCreated: Date
    public let dateModified: Date

    public init(
        id: String,
        userId: String,
        avatarId: String,
        dateCreated: Date,
        dateModified: Date
    ) {
        self.id = id
        self.userId = userId
        self.avatarId = avatarId
        self.dateCreated = dateCreated
        self.dateModified = dateModified
    }
}

// MARK: - Mocks

public extension ChatModel {
    static var mock: ChatModel { mocks[0] }

    static var mocks: [ChatModel] {
        [
            ChatModel(
                id: "chat001",
                userId: "user123",
                avatarId: "avatarA",
                dateCreated: Date(timeIntervalSince1970: 1_700_000_000),
                dateModified: Date(timeIntervalSince1970: 1_700_000_500)
            ),

            ChatModel(
                id: "chat002",
                userId: "user456",
                avatarId: "avatarB",
                dateCreated: Date(timeIntervalSince1970: 1_701_000_000),
                dateModified: Date(timeIntervalSince1970: 1_701_000_600)
            ),
            ChatModel(
                id: "chat003",
                userId: "user789",
                avatarId: "avatarC",
                dateCreated: Date(timeIntervalSince1970: 1_702_000_000),
                dateModified: Date(timeIntervalSince1970: 1_702_000_700)
            ),
            ChatModel(
                id: "chat004",
                userId: "user321",
                avatarId: "avatarD",
                dateCreated: Date(timeIntervalSince1970: 1_703_000_000),
                dateModified: Date(timeIntervalSince1970: 1_703_000_800)
            )
        ]
    }
}
