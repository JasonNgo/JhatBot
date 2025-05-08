//
//  SwiftUIView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import SwiftUI

public struct AsyncButton<Content: View, ProgressContent: View, Trigger: Equatable>: View {

    // MARK: - Properties

    public var cancellation: Trigger

    private let action: () async -> Void
    private let label: Content
    private let progress: ProgressContent

    @State private var task: Task<Void, Never>?
    @State private var isLoading = false

    // MARK: - Initializers

    public init(
        cancellation: Trigger = false,
        action: @escaping () async -> Void,
        @ViewBuilder label: () -> Content,
        @ViewBuilder progress: () -> ProgressContent
    ) {
        self.cancellation = cancellation
        self.action = action
        self.label = label()
        self.progress = progress()
    }

    // MARK: - Body

    public var body: some View {
        Button {
            isLoading = true
            task = Task {
                await action()
                isLoading = false
            }
        } label: {
            ZStack {
                label
                    .opacity(isLoading ? 0.0 : 1.0)

                progress
                    .opacity(isLoading ? 1.0 : 0.0)
            }
        }
        .disabled(isLoading)
        .onChange(of: cancellation) {
            task?.cancel()
        }
    }
}

// MARK: - Previews

#Preview {
    AsyncButton {
        try? await Task.sleep(for: .seconds(2))
    } label: {
        Text("Finish")
    } progress: {
        ProgressView()
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(Color.red)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding()
}
