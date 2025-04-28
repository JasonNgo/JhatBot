//
//  ExploreView.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Shared
import AvatarModule
import SwiftUI

public struct ExploreView: View {

    // MARK: - Properties

    @State private var featureAvatars: [AvatarModel]
    @State private var categories: [CharacterOption]

    // MARK: - Initializers

    public init(
        featuredAvatars: [AvatarModel],
        categories: [CharacterOption]
    ) {
        self.featureAvatars = featuredAvatars
        self.categories = categories
    }

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            List {
                featuredAvatarsSection
                categorySection
            }
        }
    }

    // MARK: - Components

    private var featuredAvatarsSection: some View {
        Section {
            CarouselView(items: featureAvatars) { avatar in
                ImageTextView(
                    title: avatar.name,
                    subtitle: avatar.characterDescription,
                    imageURL: avatar.profileImageURL
                )
            }
            .wrapForListStability()
            .frame(height: 200)
            .removeListRowFormatting()
        } header: {
            Text("Featured Avatars")
        }
    }

    private var categorySection: some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(categories, id: \.self) { category in
                        ImageTextView(
                            title: category.rawValue.capitalized,
                            subtitle: nil,
                            imageURL: nil
                        )
                        .aspectRatio(1.0, contentMode: .fill)
                    }
                }
            }
            .frame(height: 140)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .wrapForListStability()
            .removeListRowFormatting()
        } header: {
            Text("Categories")
        }
    }

}

// MARK: - Previews

#Preview {
    ExploreView(
        featuredAvatars: AvatarModel.mocks,
        categories: CharacterOption.allCases
    )
}
