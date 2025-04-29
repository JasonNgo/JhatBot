//
//  ChatRowCellViewBuilder.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import AvatarModule
import SwiftUI

public struct ChatRowCellViewBuilder: View {

    // MARK: - Properties

    private let currentUserId: String?
    private let chat: ChatModel
    private var getAvatar: () async -> AvatarModel?
    private var getLastMessage: () async -> ChatMessageModel?

    @State private var avatar: AvatarModel?
    @State private var lastMessage: ChatMessageModel?
    @State private var didLoadAvatar = false
    @State private var didLoadLastMessage = false

    // MARK: - Initializers

    public init(
        currentUserId: String?,
        chat: ChatModel,
        getAvatar: @escaping () -> AvatarModel?,
        getLastMessage: @escaping () -> ChatMessageModel?
    ) {
        self.currentUserId = currentUserId
        self.chat = chat
        self.getAvatar = getAvatar
        self.getLastMessage = getLastMessage
    }

    // MARK: - Body

    public var body: some View {
        ChatRowCellView(
            title: isLoading ? "xxxx xxxx" : avatar?.name,
            subtitle: subtitle,
            imageURL: avatar?.profileImageURL,
            isShowingIndicator: isLoading ? false : lastMessage?.isSeenBy("") ?? false
        )
        .task {
            avatar = await getAvatar()
            didLoadAvatar = true
        }
        .task {
            lastMessage = await getLastMessage()
            didLoadLastMessage = true
        }
    }

    // MARK: - Helpers

    private var hasSeenLastChatMessage: Bool {
        guard let lastMessage, let currentUserId else { return false }
        return lastMessage.isSeenBy(currentUserId)
    }

    private var isLoading: Bool {
        if didLoadAvatar && didLoadLastMessage {
            return false
        }

        return true
    }

    private var subtitle: String? {
        if isLoading {
            return "xxxx xxxx xxxx xxxx"
        }

        if avatar == nil && lastMessage == nil {
            return "Error loading data."
        }

        return lastMessage?.content
    }

}

// MARK: - Previews

#Preview {
    ChatRowCellViewBuilder(currentUserId: "", chat: .mock) {
        return .mock
    } getLastMessage: {
        return .mock
    }
}
