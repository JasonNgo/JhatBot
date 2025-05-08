//
//  ChatListView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import SharedModels
import SwiftUI

public struct ChatListView: View {

    // MARK: - Properties

    @State private var recentAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var chats: [ChatModel] = ChatModel.mocks

    // MARK: - Initializers

    public init(chats: [ChatModel]) {
        self.chats = chats
    }

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            List {
                if !recentAvatars.isEmpty {
                    Section {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 8) {
                                ForEach(recentAvatars, id: \.self) { avatar in
                                    if let imageName = avatar.profileImageURL {
                                        VStack(spacing: 8) {
                                            ImageLoaderView(urlString: imageName)
                                                .aspectRatio(1.0, contentMode: .fit)
                                                .clipShape(Circle())

                                            Text(avatar.name ?? "")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 10)
                        }
                        .frame(height: 120)
                        .scrollIndicators(.hidden)
                    } header: {
                        Text("Recents")
                    }
                    .removeListRowFormatting()
                }

                if !chats.isEmpty {
                    Section {
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
                        }
                    } header: {
                        Text("Chats")
                            .removeListRowFormatting()
                    }
                }
            }
            .navigationTitle("Chats")
            .overlay {
                if chats.isEmpty {
                    ContentUnavailableView(
                        "No Chats Available",
                        systemImage: "bubble",
                        description: Text("Your chats will appear here.")
                    )
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ChatListView(chats: ChatModel.mocks)
}

#Preview("ChatList - Empty State") {
    ChatListView(chats: [])
}
