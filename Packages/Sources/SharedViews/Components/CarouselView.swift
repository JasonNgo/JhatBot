//
//  CarouselView.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import SwiftUI

public struct CarouselView<Item, ContentItem>: View where Item: Hashable, ContentItem: View {

    // MARK: - Body

    public var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        contentView(item)
                            .scrollTransition(
                                .interactive.threshold(.visible(0.95)), transition: { content, phase in
                                    content.scaleEffect(phase.isIdentity ? 1 : 0.9)
                                })
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item)
                    }
                }
            }
            .scrollIndicators(scrollIndicatorVisibility)
            .scrollTargetBehavior(.paging)
            .trackScrollPosition($selectedItem)
            .onAppear {
                if selectedItem == nil {
                    selectedItem = items.first
                }
            }

            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .fill(item == selectedItem ? Color.accentColor : Color.secondary.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .animation(.linear, value: selectedItem)
        }
    }

    // MARK: - Properties

    public let scrollIndicatorVisibility: ScrollIndicatorVisibility

    private var items: [Item]
    private var contentView: (Item) -> ContentItem

    @State private var selectedItem: Item?

    // MARK: - Initializers

    public init(
        scrollIndicatorVisibility: ScrollIndicatorVisibility = .hidden,
        items: [Item],
        @ViewBuilder contentView: @escaping (Item) -> ContentItem
    ) {
        self.scrollIndicatorVisibility = scrollIndicatorVisibility
        self.items = items
        self.contentView = contentView
    }

}

// MARK: - Previews

//#Preview {
//    CarouselView()
//        .frame(height: 200)
//}
