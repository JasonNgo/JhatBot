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
    @State private var popularAvatars: [AvatarModel]

    // MARK: - Initializers

    public init(
        featuredAvatars: [AvatarModel],
        categories: [CharacterOption],
        popularAvatars: [AvatarModel]
    ) {
        self.featureAvatars = featuredAvatars
        self.categories = categories
        self.popularAvatars = popularAvatars
    }

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            List {
                featuredAvatarsSection
                categorySection
                popularSection
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
        } header: {
            Text("Featured Avatars")
        }
        .removeListRowFormatting()
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
        } header: {
            Text("Categories")
        }
        .removeListRowFormatting()
    }

    private var popularSection: some View {
        Section {
            ForEach(popularAvatars, id: \.self) { avatar in
                BasicListCellView(
                    title: avatar.name,
                    subtitle: avatar.characterDescription,
                    imageURL: avatar.profileImageURL
                )
            }
        } header: {
            Text("Popular")
        }
        .removeListRowFormatting()
    }

}

// MARK: - Previews

#Preview {
    ExploreView(
        featuredAvatars: AvatarModel.mocks,
        categories: CharacterOption.allCases,
        popularAvatars: AvatarModel.mocks
    )
}
