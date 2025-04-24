//
//  ImageLoaderView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-24.
//

import SwiftUI
// import SDWebImageSwiftUI

struct ImageLoaderView: View {

    var urlString: String = "https://picsum.photos/600/600"
    var resizingMode: ContentMode = .fill

    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                AsyncImage(url: URL(string: urlString)!)
//                WebImage
//                    .resizeable()
//                    .indicator(.activity)
//                    .aspectRatio(contentMode: resizingMode)
            )
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
}
