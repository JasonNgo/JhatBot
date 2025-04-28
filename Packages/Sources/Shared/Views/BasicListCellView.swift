//
//  BasicListCellView.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import SwiftUI

public struct BasicListCellView: View {

    // MARK: - Properties

    public private(set) var title: String?
    public private(set) var subtitle: String?
    public private(set) var imageURL: String?

    // MARK: - Initializers

    public init(
        title: String? = nil,
        subtitle: String? = nil,
        imageURL: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }

    // MARK: - Body

    public var body: some View {
        HStack {
            ZStack {
                if let imageURL {
                    ImageLoaderView(urlString: imageURL)
                } else {
                    Rectangle()
                        .background(Color.secondary.opacity(0.5))
                }
            }
            .aspectRatio(1.0, contentMode: .fit)
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }

                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background()
    }

}

#Preview {
    ZStack {
        VStack {
            BasicListCellView()
            BasicListCellView()
            BasicListCellView()
            BasicListCellView()
        }
    }
}
