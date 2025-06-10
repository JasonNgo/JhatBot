//
//  CreateAvatarView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import Shared
import SharedModels
import SharedViews
import AuthService
import AvatarRepository
import ImageGenerator
import SwiftUI

public struct CreateAvatarView: View {

    // MARK: - Properties

    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    @Environment(AvatarRepository.self) private var avatarRepository
    @Environment(ImageGenerator.self) private var imageGenerator

    @State private var isLoadingImage = false
    @State private var image: UIImage?
    @State private var imageData: Data?

    @State private var isLoading = false
    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .default
    @State private var characterAction: CharacterAction = .default
    @State private var characterLocation: CharacterLocation = .default

    // MARK: - Initializers

    public init() {}

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            List {
                nameSection
                attributesSection
                imageSection
                saveSection
            }
            .navigationTitle("Create Avatar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    closeButton
                }
            }
        }
    }

    // MARK: - Components

    private var closeButton: some View {
        Button(action: onCloseButtonTapped) {
            Image(systemName: "xmark")
                .font(.title2)
                .fontWeight(.semibold)
        }
    }

    private var nameSection: some View {
        Section {
            TextField("Player 1", text: $avatarName)
        } header: {
            Text("Name your avatar*")
        }
    }

    private var attributesSection: some View {
        Section {
            Picker(selection: $characterOption) {
                ForEach(CharacterOption.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                        .tag(option)
                }
            } label: {
                Text("is a...")
            }

            Picker(selection: $characterAction) {
                ForEach(CharacterAction.allCases, id: \.self) { action in
                    Text(action.rawValue.capitalized)
                        .tag(action)
                }
            } label: {
                Text("that is...")
            }

            Picker(selection: $characterLocation) {
                ForEach(CharacterLocation.allCases, id: \.self) { location in
                    Text(location.rawValue.capitalized)
                        .tag(location)
                }
            } label: {
                Text("in the...")
            }
        } header: {
            Text("Attributes")
        }
    }

    private var imageSection: some View {
        Section {
            HStack(alignment: .top) {
                ZStack {
                    Button(action: onCreateImageButtonTapped) {
                        Text("Generate image")
                            .underline()
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .opacity(isLoading ? 0 : 1)

                    ProgressView()
                        .foregroundStyle(Color.accentColor)
                        .opacity(isLoadingImage ? 1 : 0)
                }
                .disabled(isLoadingImage || avatarName.isEmpty)

                Circle()
                    .fill(Color.secondary.opacity(0.3))
                    .overlay {
                        ZStack {
                            if let generatedImage = self.image {
                                Image(uiImage: generatedImage)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                    .clipShape(Circle())
            }
        }
    }

    private var saveSection: some View {
        Section {
            AsyncButton(
                action: onActionButtonTapped,
                label: {
                    Text("Save")
                },
                progress: {
                    ProgressView()
                }
            )
            .withCallToActionStyle()
            .removeListRowFormatting()
            .disabled(isLoadingImage || isLoading || image == nil || avatarName.isEmpty)
            .opacity(isLoading ? 0.5 : 1.0)
        }
    }

    // MARK: - Actions

    private func onCloseButtonTapped() {
        dismiss.callAsFunction()
    }

    private func onCreateImageButtonTapped() {
        isLoadingImage = true

        let prompt = AvatarDescriptionBuilder(
            characterOption: characterOption,
            characterAction: characterAction,
            characterLocation: characterLocation
        )
            .characterDescription

        Task {
            do {
                let data = try await imageGenerator.generateImage(prompt: prompt)
                let image = UIImage(data: data)

                self.image = image
                self.imageData = data
            } catch {
                print("Error generating image: \(error)")
            }

            isLoadingImage = false
        }
    }

    private func onActionButtonTapped() async {
        guard let imageData else { return }

        isLoading = true

        Task {
            do {
                let authorID = try authManager.getAuthId()

                let avatar = AvatarModel(
                    avatarID: UUID().uuidString,
                    name: avatarName,
                    characterOption: characterOption,
                    characterAction: characterAction,
                    characterLocation: characterLocation,
                    profileImageURL: nil,
                    authorID: authorID,
                    dateCreated: .now
                )

                try await avatarRepository.createAvatar(avatar: avatar, imageData: imageData)
            }
        }

        isLoading = false
    }

}

#Preview {
    CreateAvatarView()
        .environment(ImageGenerator(service: .mock))
}
