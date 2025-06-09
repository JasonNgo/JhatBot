//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-26.
//

import Foundation

extension FileManager {
    /// Saves a Codable object as a .txt file (JSON encoded) in the specified directory.
    public func saveDocument<T: Codable>(
        key: String,
        value: T?
    ) throws {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        guard let _ = urls.first else {
            throw NSError(domain: "FileManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Directory not found"])
        }

        let fileURL = getDocumentURL(key: key)
        let data = try JSONEncoder().encode(value)

        try data.write(to: fileURL)
    }

    public func getDocument<T: Codable>(key: String) -> T? {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        guard let _ = urls.first else {
            return nil
        }

        let fileURL = getDocumentURL(key: key)

        guard
            let text = try? String(contentsOf: fileURL, encoding: .utf8),
            let data = text.data(using: .utf8)
        else {
            return nil
        }

        return try? JSONDecoder().decode(T.self, from: data)
    }

    /// Removes a specific .txt file from the specified directory.
    public func removeDocument(
        key: String
    ) throws {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        guard let dirURL = urls.first else {
            throw NSError(domain: "FileManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Directory not found"])
        }

        let fileURL = getDocumentURL(key: key)

        if fileExists(atPath: fileURL.path) {
            try removeItem(at: fileURL)
        } else {
            throw NSError(domain: "FileManagerError", code: 3, userInfo: [NSLocalizedDescriptionKey: "File not found"])
        }
    }

    private func getDocumentURL(key: String) -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("\(key).txt")
    }
}
