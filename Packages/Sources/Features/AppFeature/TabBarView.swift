//
//  TabBarView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SharedModels
import ExploreFeature
import ChatFeature
import ProfileFeature

import SwiftUI

public struct TabBarView: View {

    public var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "eyes")
                }

            ChatListView(chats: ChatModel.mocks)
                .tabItem {
                    Label("Chats", systemImage: "bubble.left.and.bubble.right.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }

}

#Preview {
    TabBarView()
}
