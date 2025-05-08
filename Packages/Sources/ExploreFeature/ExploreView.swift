//
//  ExploreView.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Shared
import SharedModels
import SharedViews
import MessageFeature
import CategoryFeature
import SwiftUI

public struct ExploreView: View {

    enum Route: Hashable {
        case chat(AvatarModel)
        case category(CharacterOption)
    }

    // MARK: - Properties

    @State private var featureAvatars: [AvatarModel]
    @State private var categories: [CharacterOption]
    @State private var popularAvatars: [AvatarModel]

    @State private var selectedAvatar: AvatarModel?
    @State private var selectedCategory: CharacterOption?

    @State private var path: [Route] = []

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
        NavigationStack(path: $path) {
            List {
                featuredAvatarsSection
                categorySection
                popularSection
            }
            .navigationDestination(for: Route.self) { newValue in
                switch newValue {
                case let .chat(avatar):
                    MessageView()
                case let .category(category):
                    CategoryListView(
                        category: category,
                        imageName: Constants.randomImageURLString,
                        avatars: AvatarModel.mocks
                    )
                }
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
                .anyButton {
                    onAvatarSelected(avatar)
                }
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
                            imageURL: Constants.randomImageURLString
                        )
                        .aspectRatio(1.0, contentMode: .fill)
                        .anyButton(.press) {
                            onCategorySelected(category)
                        }
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

    // MARK: - Actions

    private func onAvatarSelected(_ avatar: AvatarModel) {
        path.append(.chat(avatar))
    }

    private func onCategorySelected(_ category: CharacterOption) {
        path.append(.category(category))
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
