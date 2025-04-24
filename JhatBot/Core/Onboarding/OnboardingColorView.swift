//
//  OnboardingColorView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-24.
//

import SwiftUI

struct OnboardingColorView: View {
    // Predefined set of colors
    let colors: [Color] = [
        .red, .green, .blue,
        .orange, .purple, .yellow,
        .pink, .teal, .gray
    ]

    @State private var selectedColor: Color?
    private var isActionButtonEnabled: Bool { selectedColor != nil }

    var body: some View {
        ScrollView {
            colorGrid
                .padding(.horizontal, 24)
                .animation(.smooth, value: selectedColor)
        }
        .safeAreaInset(
            edge: .bottom,
            alignment: .center,
            spacing: 16,
            content: {
                actionButton
            }
        )
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Components

    private var colorGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
            alignment: .center,
            spacing: 16,
            pinnedViews: [.sectionHeaders]
        ) {
            Section(content: {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: selectedColor == color ? 4 : 0)
                        )
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }, header: {
                Text("Select a profile color")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            })
        }
    }

    private var actionButton: some View {
        ZStack {
            NavigationLink {
                if let selectedColor {
                    OnboardingCompletedView(selectedColor: selectedColor)
                }
            } label: {
                Text("Continue")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(
                        isActionButtonEnabled ? .accent : Color.gray,
                        in: .rect(cornerRadius: 16)
                    )
            }
            .disabled(!isActionButtonEnabled)
        }
        .padding(16)
        .background(.background)
    }
}

#Preview {
    NavigationStack {
        OnboardingColorView()
    }
    .environment(AppState())
}
