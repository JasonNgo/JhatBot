//
//  ChatListView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

public struct ChatListView: View {

    // MARK: - Properties

    @State private var chats: [ChatModel]

    // MARK: - Initializers

    public init(chats: [ChatModel]) {
        self.chats = chats
    }

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            List {
                ForEach(chats, id: \.self) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: nil,
                        chat: chat,
                        getAvatar: {
                            return .mock
                        },
                        getLastMessage: {
                            return .mock
                        }
                    )
                    .removeListRowFormatting()
                }
            }
            .navigationTitle("Chats")
        }
    }
}

// MARK: - Previews

#Preview {
    ChatListView(chats: ChatModel.mocks)
}
