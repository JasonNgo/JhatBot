//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Foundation

public struct ChatMessageModel {
    public let id: String
    public let chatId: String
    public let authorId: String?
    public let content: String?
    public let seenByIds: Set<String>
    public let dateCreated: Date?

    public init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: String? = nil,
        seenByIds: Set<String> = Set(),
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }
}

// MARK: - Mocks

extension ChatMessageModel {
    static var mock: ChatMessageModel { mocks[0] }

    static var mocks: [ChatMessageModel] {
        [
            ChatMessageModel(
                id: "msg001",
                chatId: "chat001",
                authorId: "user123",
                content: "Hey, how are you?",
                seenByIds: ["user456", "user789"],
                dateCreated: Date(timeIntervalSince1970: 1_700_000_000)
            ),
            ChatMessageModel(
                id: "msg002",
                chatId: "chat001",
                authorId: "user456",
                content: "Doing well, thanks! You?",
                seenByIds: ["user123"],
                dateCreated: Date(timeIntervalSince1970: 1_700_000_100)
            ),
            ChatMessageModel(
                id: "msg003",
                chatId: "chat002",
                authorId: nil, // System message
                content: "User789 has joined the chat.",
                seenByIds: [],
                dateCreated: Date(timeIntervalSince1970: 1_701_000_000)
            ),
            ChatMessageModel(
                id: "msg004",
                chatId: "chat003",
                authorId: "user321",
                content: "Let's schedule the meeting for tomorrow.",
                seenByIds: ["user123", "user456", "user789"],
                dateCreated: Date(timeIntervalSince1970: 1_702_000_000)
            )
        ]
    }
}
