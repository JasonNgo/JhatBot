//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-06-09.
//

import Foundation

extension ImageUploaderService {
    static public let mock = Self(
        uploadImage: { data, path in
            try await Task.sleep(for: .seconds(2))

            return URL(string: "")!
        }
    )
}
