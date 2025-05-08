//
//  SwiftUIView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-06.
//

import Shared
import SharedModels
import SharedViews
import SwiftUI

public struct CategoryListView: View {

    // MARK: - Properties

    private let category: CharacterOption
    private let imageName: String?
    @State private var avatars: [AvatarModel]

    // MARK: - Initializers

    public init(
        category: CharacterOption,
        imageName: String?,
        avatars: [AvatarModel]
    ) {
        self.category = category
        self.imageName = imageName
        self.avatars = avatars
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

            ForEach(avatars, id: \.self) { avatar in
                BasicListCellView(
                    title: avatar.name,
                    subtitle: avatar.characterDescription,
                    imageURL: avatar.profileImageURL
                )
                .removeListRowFormatting()
            }
        }
        .listStyle(.plain)
        .ignoresSafeArea()
    }

}

#Preview {
    CategoryListView(
        category: .alien,
        imageName: Constants.randomImageURLString,
        avatars: AvatarModel.mocks
    )
}
