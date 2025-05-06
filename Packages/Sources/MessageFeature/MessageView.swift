//
//  MessageView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import Shared
import AvatarModule
import ChatFeature
import ProfileFeature
import SwiftUI

public struct MessageView: View {

    // MARK: - Properties

    @State private var messages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel? = .mock
    @State private var currentUser: UserModel? = .mock

    @State private var text: String = ""
    @State private var scrollPosition: String?

    @State private var showAlert: AppAlert?
    @State private var showChatSettings: AppAlert?
    @State private var showProfileModal: Bool = false

    // MARK: - Initializers

    public init() {

    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            chatSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "ellipsis")
                    .padding(8)
                    .anyButton {
                        onChatSettingsButtonTapped()
                    }
            }
        }
        .showCustomAlert(type: .confirmationDialog, alert: $showChatSettings)
        .showModal($showProfileModal) {
            if let avatar {
                ProfileImageModalView(
                    imageName: avatar.profileImageURL,
                    title: avatar.name,
                    subtitle: avatar.characterOption?.rawValue.capitalized,
                    headline: avatar.characterDescription,
                    onCloseButtonTapped: {
                        showProfileModal = false
                    }
                )
                .padding(40)
                .transition(.slide)
            }
        }
    }

    // MARK: - Components

    private var chatSection: some View {
        ScrollView {
            LazyVStack {
                ForEach(messages) { message in
                    let isCurrentUser = message.authorId == currentUser?.userId
                    ChatMessageViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        imageName: isCurrentUser ? nil : avatar?.profileImageURL,
                        onImageTapped: {
                            onChatMessageProfileImageTapped()
                        }
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .animation(.default, value: messages.count)
        .animation(.default, value: scrollPosition)
    }

    private var textFieldSection: some View {
        TextField("Say something", text: $text)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .overlay(
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .padding(.trailing, 4)
                    .foregroundStyle(Color.accentColor)
                    .anyButton(.plain, action: {
                        onSendMessageButtonTapped()
                    }),
                alignment: .trailing
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(uiColor: .systemBackground))
                }
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color(uiColor: .secondarySystemBackground))
    }

    // MARK: - Actions

    private func onChatSettingsButtonTapped() {
        showChatSettings = AppAlert(
            title: nil,
            subtitle: "What would you like to do?",
            buttons: {
                AnyView(Group {
                    Button("Report User / Chat", role: .destructive) {

                    }
                    Button("Delete Chat", role: .destructive) {

                    }
                })
            })
    }

    private func onChatMessageProfileImageTapped() {
        showProfileModal = true
    }

    private func onSendMessageButtonTapped() {
        guard let currentUser else { return }

        let content = text

        let message = ChatMessageModel(
            id: UUID().uuidString,
            chatId: UUID().uuidString,
            authorId: currentUser.userId,
            content: content,
            seenByIds: Set(),
            dateCreated: Date()
        )

        messages.append(message)
        scrollPosition = message.id
        text = ""
    }

}

// MARK: - Previews

#Preview {
    NavigationStack {
        MessageView()
    }
}
