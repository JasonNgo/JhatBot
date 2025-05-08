//
//  ProfileImageModalView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import Shared
import SharedViews
import SwiftUI

public struct ProfileImageModalView: View {

    // MARK: - Properties

    public let imageName: String?
    public let title: String?
    public let subtitle: String?
    public let headline: String?
    public let onCloseButtonTapped: (() -> Void)?

    // MARK: - Init

    public init(
        imageName: String? = nil,
        title: String? = nil,
        subtitle: String? = nil,
        headline: String? = nil,
        onCloseButtonTapped: @escaping () -> Void
    ) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.headline = headline
        self.onCloseButtonTapped = onCloseButtonTapped
    }

    // MARK: - Body

    public var body: some View {
        VStack {
            if let imageName {
                ImageLoaderView(urlString: imageName, forceTransitionAnimation: true)
                    .aspectRatio(1.0, contentMode: .fit)
            }

            VStack(alignment: .leading, spacing: 8) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }

                if let subtitle {
                    Text(subtitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(Color.black)
                .padding(8)
                .withTappableBackground {
                    closeButtonTapped()
                }
        }
    }

    // MARK: - Actions

    private func closeButtonTapped() {
        onCloseButtonTapped?()
    }

}

// MARK: - Previews

#Preview("Modal with Image") {
    ZStack {
        Color.gray.ignoresSafeArea()

        ProfileImageModalView(
            imageName: Constants.randomImageURLString,
            title: "Alpha",
            subtitle: "Pet",
            headline: "Headline text like a sentence",
            onCloseButtonTapped: {

            }
        )
        .padding(40)
    }
}

#Preview("Modal without Image") {
    ZStack {
        Color.gray.ignoresSafeArea()

        ProfileImageModalView(
            imageName: nil,
            title: "Alpha",
            subtitle: "Pet",
            headline: "Headline text like a sentence",
            onCloseButtonTapped: {

            }
        )
        .padding(40)
    }
}
