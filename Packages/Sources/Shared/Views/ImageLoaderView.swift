//
//  ImageLoaderView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-24.
//

import SwiftUI
import SDWebImageSwiftUI

public struct ImageLoaderView: View {

    public private(set) var urlString: String
    public private(set) var resizingMode: ContentMode

    public init(
        urlString: String = "https://picsum.photos/600/600",
        resizingMode: ContentMode = .fill
    ) {
        self.urlString = urlString
        self.resizingMode = resizingMode
    }

    public var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                WebImage(url: URL(string: urlString)!)
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
            )
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
}
