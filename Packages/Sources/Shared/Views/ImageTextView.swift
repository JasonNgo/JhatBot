//
//  ImageTextView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-25.
//

import SwiftUI

public struct ImageTextView: View {

    private(set) var title: String?
    private(set) var subtitle: String?
    private(set) var imageURL: String?

    private var textNotEmpty: Bool {
        title != nil || subtitle != nil
    }

    public init(
        title: String? = nil,
        subtitle: String? = nil,
        imageURL: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }

    public var body: some View {
        imageSection(imageURL: imageURL)
            .overlay(alignment: .bottomLeading) {
                if textNotEmpty {
                    textSection
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func imageSection(imageURL: String?) -> some View {
        ZStack {
            if let imageURL {
                ImageLoaderView(urlString: imageURL)
            } else {
                Rectangle()
                    .fill(Color.accentColor)
            }
        }
    }

    private var textSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title {
                Text(title)
                    .font(.headline)
            }
            if let subtitle {
                Text(subtitle)
                    .font(.subheadline)
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            LinearGradient(
                colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.3),
                    Color.black.opacity(0.4)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

}

#Preview {
    ScrollView {
        VStack {
            ImageTextView(
                title: "Hello World",
                subtitle: "Hello Jorld",
                imageURL: "https://picsum.photos/600/600"
            )
            .frame(width: 300, height: 300)

            ImageTextView(
                title: "Hello World",
                imageURL: "https://picsum.photos/600/600"
            )
            .frame(width: 300, height: 300)

            ImageTextView(
                imageURL: "https://picsum.photos/600/600"
            )
            .frame(width: 300, height: 300)

            ImageTextView(
                title: "Hello World",
                subtitle: "Hello Jorld",
                imageURL: "https://picsum.photos/600/600"
            )
            .frame(width: 300, height: 400)
        }
        .frame(maxWidth: .infinity)
    }
}
