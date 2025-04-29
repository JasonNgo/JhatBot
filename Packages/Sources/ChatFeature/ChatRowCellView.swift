//
//  ChatRowCellView.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Shared
import SwiftUI

public struct ChatRowCellView: View {

    // MARK: - Properties

    public private(set) var title: String?
    public private(set) var subtitle: String?
    public private(set) var imageURL: String?
    public private(set) var isShowingIndicator = false

    // MARK: - Initializers

    public init(
        title: String? = nil,
        subtitle: String? = nil,
        imageURL: String? = nil,
        isShowingIndicator: Bool = false
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.isShowingIndicator = isShowingIndicator
    }

    // MARK: - Body

    public var body: some View {
        HStack {
            ZStack {
                if let imageURL {
                    ImageLoaderView(urlString: imageURL)
                } else {
                    Rectangle()
                        .background(Color.secondary.opacity(0.5))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }

                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if isShowingIndicator {
                Text("NEW")
                    .font(.caption)
                    .foregroundStyle(Color.white)
                    .bold()
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }

}

#Preview {
    ChatRowCellView()
}
