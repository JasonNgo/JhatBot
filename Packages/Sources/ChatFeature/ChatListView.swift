//
//  ChatListView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

public struct ChatListView: View {
    public var body: some View {
        NavigationStack {
            Text("Chats")
                .navigationTitle("Chats")
        }
    }
}

#Preview {
    ChatListView()
}
