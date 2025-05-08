//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-06.
//

import Foundation

public struct FileDownloadRequest {

    // MARK: - Properties

    public let url: URL
    public let destination: String

    // MARK: - Initializers

    public init(
        url: URL,
        destination: String
    ) {
        self.url = url
        self.destination = destination
    }

}

struct FileDownloadTask {

}

//
//struct FileDownloader {
//
//    var download: (FileDownloadRequest) -> FileDownloadTask
//
//    
//
//
//}

public protocol FileDownloader {
    func download(request: FileDownloadRequest) -> FileDownloadTask
    func pauseAll()
    func resumeAll()
    func cancelAll()
    func listActiveTasks() -> [FileDownloadTask]
}

public struct FileDownloaderConfig {
    public let maxParallelDownloads: Int
    public let customerHeaders: [String: String]

    public init(
        maxParallelDownloads: Int = 6,
        customerHeaders: [String : String] = [:]
    ) {
        self.maxParallelDownloads = maxParallelDownloads
        self.customerHeaders = customerHeaders
    }
}
