//
//  ImageLoaderView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-24.
//

import SwiftUI
import SDWebImageSwiftUI

public struct ImageLoaderView: View {

    public let urlString: String
    public let resizingMode: ContentMode
    public let forceTransitionAnimation: Bool

    public init(
        urlString: String = "https://picsum.photos/600/600",
        resizingMode: ContentMode = .fill,
        forceTransitionAnimation: Bool = false
    ) {
        self.urlString = urlString
        self.resizingMode = resizingMode
        self.forceTransitionAnimation = forceTransitionAnimation
    }

    public var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(
                WebImage(url: URL(string: urlString)!)
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
            )
            .clipped()
            .ifSatisfiesCondition(forceTransitionAnimation) { content in
                content
                    .drawingGroup()
            }
    }
}

#Preview {
    ImageLoaderView()
}
