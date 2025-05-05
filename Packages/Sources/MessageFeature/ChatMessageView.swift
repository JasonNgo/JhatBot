//
//  ChatMessageView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import Shared
import SwiftUI

public struct ChatMessageView: View {

    // MARK: - Properties

    public private(set) var text: String
    public private(set) var textColor: Color
    public private(set) var backgroundColor: Color
    public private(set) var showImage: Bool
    public private(set) var imageName: String?

    private let offset: CGFloat = 12

    // MARK: - Initializers

    public init(
        text: String,
        textColor: Color = .primary,
        backgroundColor: Color = Color(uiColor: .systemGray5),
        showImage: Bool = false,
        imageName: String? = nil
    ) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.showImage = showImage
        self.imageName = imageName
    }

    // MARK: - Body

    public var body: some View {
        HStack(alignment: .top, spacing: 8) {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(Color.secondary)
                }
            }
            .frame(width: 45, height: 45)
            .clipShape(Circle())
            .offset(y: offset)

            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.bottom, offset)
    }

}
