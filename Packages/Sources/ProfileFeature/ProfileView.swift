//
//  ProfileView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import AvatarModule
import SwiftUI

public struct ProfileView: View {

    // MARK: - Properties

    @State private var currentUser: UserModel?
    @State private var avatars: [AvatarModel] = []

    @State private var isLoading = true
    @State private var showSettings = false
    @State private var showAddAvatar = false

    // MARK: - Initializers

    public init() {
        
    }

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            List {
                headerView
                avatarsListView
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $showAddAvatar) {
                Text("Add Avatar")
            }
            .task {
                await loadData()
            }
        }
    }

    // MARK: - Components

    private var headerView: some View {
        Section {
            ZStack {
                Circle()
                    .fill(currentUser?.profileColorCalculated ?? Color.accentColor)
            }
            .frame(width: 125, height: 125)
            .frame(maxWidth: .infinity)
            .removeListRowFormatting()
        }
    }
    
    private var avatarsListView: some View {
        Section {
            if avatars.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        emptyAvatarsView
                    }
                }
                .frame(maxWidth: .infinity)
            } else {
                ForEach(avatars, id: \.self) { avatar in
                    BasicListCellView(
                        title: avatar.name,
                        subtitle: nil,
                        imageURL: avatar.profileImageURL
                    )
                }
                .onDelete(perform: onDeleteAvatar(_:))
            }
        } header: {
            HStack {
                Text("MY AVATARS")

                Spacer()

                Button(action: onAddAvatarTapped) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.vertical, 8)
        }
        .removeListRowFormatting()
    }
    
    private var emptyAvatarsView: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.fill.questionmark")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            Text("No Avatars Available")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Create an avatar to get started")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(action: onAddAvatarTapped) {
                HStack {
                    Image(systemName: "plus")
                    Text("Create Avatar")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.top, 8)
        }
        .padding(.vertical, 40)
    }

    private var settingsButton: some View {
        Button(action: onSettingsButtonTapped) {
            Image(systemName: "gear")
        }
    }

    // MARK: - Actions

    private func onSettingsButtonTapped() {
        showSettings = true
    }
    
    private func onAddAvatarTapped() {
        showAddAvatar = true
    }

    private func onDeleteAvatar(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        avatars.remove(at: index)
    }

    private func loadData() async {
        try? await Task.sleep(for: .seconds(3))
        isLoading = false
        avatars = AvatarModel.mocks
    }

}

// MARK: - Previews

#Preview {
    ProfileView()
}
