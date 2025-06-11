import SharedModels
import Foundation
import SwiftData

@Model
public class AvatarEntity {

    // MARK: - Properties

    @Attribute(.unique) var avatarID: String
    var name: String?
    var characterOption: CharacterOption?
    var characterAction: CharacterAction?
    var characterLocation: CharacterLocation?
    var profileImageURL: String?
    var authorID: String?
    var dateCreated: Date?
    var dateAdded: Date

    public init(from model: AvatarModel) {
        self.avatarID = model.avatarID
        self.name = model.name
        self.characterOption = model.characterOption
        self.characterAction = model.characterAction
        self.characterLocation = model.characterLocation
        self.profileImageURL = model.profileImageURL
        self.authorID = model.authorID
        self.dateCreated = model.dateCreated
        self.dateAdded = .now
    }

    public func toModel() -> AvatarModel {
        AvatarModel(
            avatarID: self.avatarID,
            name: self.name,
            characterOption: self.characterOption,
            characterAction: self.characterAction,
            characterLocation: self.characterLocation,
            profileImageURL: self.profileImageURL,
            authorID: self.authorID,
            dateCreated: self.dateCreated
        )
    }

}


