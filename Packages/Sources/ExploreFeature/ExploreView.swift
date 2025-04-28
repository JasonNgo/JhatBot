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

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            ImageTextView(
                title: avatar.name,
                subtitle: avatar.characterDescription,
                imageURL: avatar.profileImageURL
            )
        }
    }

    // MARK: - Properties

    let avatar: AvatarModel.mock

}

#Preview {
    ExploreView()
}
