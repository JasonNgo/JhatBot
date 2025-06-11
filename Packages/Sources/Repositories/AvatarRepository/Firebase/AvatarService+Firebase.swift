//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import FirebaseFirestore
import SharedModels
import Foundation

extension AvatarService {

    fileprivate static let collection = Firestore.firestore().collection("avatars")

    static public let firebase = Self(
        createAvatar: { avatar in
            try collection
                .document(avatar.avatarID)
                .setData(from: avatar, merge: true)
        },
        getAvatar: { id in
            try await collection
                .document(id)
                .getDocument(as: AvatarModel.self)
        },
        getFeaturedAvatars: {
            let snapshot = try await collection.limit(to: 50).getDocuments()
            let avatars = try snapshot.documents.map({ try $0.data(as: AvatarModel.self) })

            return avatars.shuffled().first(upTo: 5) ?? []
        },
        getPopularAvatars: {
            let snapshot = try await collection.limit(to: 200).getDocuments()
            let avatars = try snapshot.documents.map({ try $0.data(as: AvatarModel.self) })

            return avatars
        },
        getAvatarsForCategory: { category in
            let snapshot = try await collection
                .whereField(AvatarModel.CodingKeys.characterOption.rawValue, isEqualTo: category.rawValue)
                .limit(to: 200)
                .getDocuments()

            let avatars = try snapshot.documents.map({ try $0.data(as: AvatarModel.self) })

            return avatars
        },
        getAvatarsForAuthor: { authorId in
            let snapshot = try await collection
                .whereField(AvatarModel.CodingKeys.authorID.rawValue, isEqualTo: authorId)
                .limit(to: 200)
                .getDocuments()

            let avatars = try snapshot.documents.map({ try $0.data(as: AvatarModel.self) })

            return avatars
        }
    )

}
