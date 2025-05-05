//
//  MessageView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import Shared
import SwiftUI

public struct MessageView: View {

    @State private var messages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel? = .mock
    @State private var currentUser: UserModel = .mock

    public var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack {
                    ForEach(messages) { message in
                        let isCurrentUser = message.authorId == currentUser?.userId
                        ChatMessageViewBuilder(
                            message: message,
                            isCurrentUser: isCurrentUser,
                            imageName: isCurrentUser ? nil : avatar?.profileImageURL
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(8)

                Rectangle()
                    .frame(height: 50)
            }
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
    }
}



#Preview {
    MessageView()
}
