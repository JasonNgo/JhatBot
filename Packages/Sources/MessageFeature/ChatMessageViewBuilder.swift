//
//  ChatMessageViewBuilder.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import Shared
import ChatFeature
import SwiftUI

public struct ChatMessageViewBuilder: View {

    // MARK: - Properties

    public private(set) var message: ChatMessageModel = .mock
    public private(set) var isCurrentUser: Bool = false
    public private(set) var imageName: String?

    private let padding: CGFloat = 75

    // MARK: - Initializers

    public init(
        message: ChatMessageModel,
        isCurrentUser: Bool,
        imageName: String? = nil
    ) {
        self.message = message
        self.isCurrentUser = isCurrentUser
        self.imageName = imageName
    }

    // MARK: - Body

    public var body: some View {
        ChatMessageView(
            text: message.content ?? "",
            textColor: isCurrentUser ? Color.white : Color.primary,
            backgroundColor: isCurrentUser ? Color.accentColor : Color(uiColor: .systemGray5),
            showImage: !isCurrentUser,
            imageName: imageName
        )
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
        .padding(.leading, isCurrentUser ? padding : 0)
        .padding(.trailing, isCurrentUser ? 0 : padding)
    }

}

// MARK: - Previews

#Preview {
//    ChatMessageViewBuilder()
}
