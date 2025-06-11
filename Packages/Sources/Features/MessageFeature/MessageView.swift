//
//  MessageView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import Shared
import SharedModels
import SharedViews
import ChatFeature
import ProfileFeature
import AvatarRepository

import SwiftUI

public struct MessageView: View {

    // MARK: - Properties

    @State private var messages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel?
    @State private var currentUser: UserModel? = .mock

    @State private var text: String = ""
    @State private var scrollPosition: String?

    @State private var showAlert: AppAlert?
    @State private var showChatSettings: AppAlert?
    @State private var showProfileModal: AvatarModel?

    // MARK: - Dependencies

    @Environment(AvatarRepository.self) private var avatarRepository

    private let avatarId: String

    // MARK: - Initializers

    public init(avatarId: String) {
        self.avatarId = avatarId
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
        .showModal($showProfileModal) { avatar in
            if let avatar {
                ProfileImageModalView(
                    imageName: avatar.profileImageURL,
                    title: avatar.name,
                    subtitle: avatar.characterOption?.rawValue.capitalized,
                    headline: avatar.characterDescription,
                    onCloseButtonTapped: {
                        showProfileModal = nil
                    }
                )
                .padding(40)
                .transition(.slide)
            }
        }
        .task {
            await loadAvatar()
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

    private func loadAvatar() async {
        do {
            self.avatar = try await avatarRepository.getAvatar(id: avatarId)
            if let avatar = self.avatar {
                try? await avatarRepository.addRecentAvatar(avatar)
            }
        } catch {
            print("Error fetching avatar with id: \(avatarId)")
        }
    }

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
            }
        )
    }

    private func onChatMessageProfileImageTapped() {
        showProfileModal = avatar
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
        MessageView(avatarId: AvatarModel.mock.avatarID)
            .environment(AvatarRepository(service: .mock, persistence: .mock, imageUploader: .init(service: .mock)))
    }
}
