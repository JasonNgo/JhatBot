//
//  SwiftUIView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-06.
//

import Shared
import SharedModels
import SharedViews
import AvatarRepository
import SwiftUI

public struct CategoryListView: View {

    // MARK: - Properties

    private let category: CharacterOption
    private let imageName: String?

    @State private var avatars: [AvatarModel] = []

    // MARK: - Dependencies

    @Environment(AvatarRepository.self) private var avatarRepository

    // MARK: - Initializers

    public init(
        category: CharacterOption,
        imageName: String?
    ) {
        self.category = category
        self.imageName = imageName
    }

    // MARK: - Body

    public var body: some View {
        List {
            ImageTextView(
                title: category.rawValue.capitalized,
                subtitle: nil,
                imageURL: Constants.randomImageURLString,
                cornerRadius: 0
            )
            .aspectRatio(1.0, contentMode: .fit)
            .removeListRowFormatting()

            if avatars.isEmpty {
                ProgressView()
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
                    .removeListRowFormatting()
            } else {
                ForEach(avatars, id: \.self) { avatar in
                    BasicListCellView(
                        title: avatar.name,
                        subtitle: avatar.characterDescription,
                        imageURL: avatar.profileImageURL
                    )
                    .removeListRowFormatting()
                }
            }
        }
        .listStyle(.plain)
        .ignoresSafeArea()
        .task {
            await loadData()
        }
    }

    // MARK: - Actions

    private func loadData() async {
        do {
            self.avatars = try await avatarRepository.getAvatarsForCategory(category)
        } catch {
            
        }
    }

}

#Preview {
    CategoryListView(
        category: .alien,
        imageName: Constants.randomImageURLString
    )
}
