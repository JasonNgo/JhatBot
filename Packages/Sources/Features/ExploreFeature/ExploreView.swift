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
import AvatarRepository
import SwiftUI

public struct ExploreView: View {

    enum Route: Hashable {
        case chat(AvatarModel)
        case category(CharacterOption)
    }

    // MARK: - Properties

    @Environment(AvatarRepository.self) private var avatarRepository

    @State private var featureAvatars: [AvatarModel] = []
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var popularAvatars: [AvatarModel] = []

    @State private var selectedAvatar: AvatarModel?
    @State private var selectedCategory: CharacterOption?

    @State private var path: [Route] = []

    // MARK: - Initializers

    public init() {}

    // MARK: - Body

    public var body: some View {
        NavigationStack(path: $path) {
            List {
                if !featureAvatars.isEmpty {
                    featuredAvatarsSection
                }

                if !popularAvatars.isEmpty {
                    categorySection
                    popularSection
                }
            }
            .task {
                await loadFeaturedAvatars()
            }
            .task {
                await loadPopularAvatars()
            }
            .refreshable(action: {
                await loadData()
            })
            .navigationDestination(for: Route.self) { newValue in
                switch newValue {
                case let .chat(avatar):
                    MessageView(avatarId: avatar.avatarID)
                case let .category(category):
                    CategoryListView(
                        category: category,
                        imageName: Constants.randomImageURLString
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
                .anyButton {
                    onAvatarSelected(avatar)
                }
            }
        } header: {
            Text("Popular")
        }
        .removeListRowFormatting()
    }

    // MARK: - Data

    private func loadData() async {
        await loadFeaturedAvatars()
        await loadPopularAvatars()
    }

    private func loadFeaturedAvatars() async {
        print("fetching featured avatars")
        do {
            self.featureAvatars = try await avatarRepository.getPopularAvatars()
        } catch {
            print("Error loading featured avatars: \(error)")
        }
    }

    private func loadPopularAvatars() async {
        do {
            self.popularAvatars = try await avatarRepository.getPopularAvatars()
        } catch {
            print("Error loading popular avatars: \(error)")
        }
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
    ExploreView()
        .environment(AvatarRepository(service: .mock, persistence: .mock, imageUploader: .init(service: .mock)))
}
