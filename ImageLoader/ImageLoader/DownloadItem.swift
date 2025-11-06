//
//  DownloadItem.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 05.11.2025.
//

import UIKit

enum DownloadState {
    case queued
    case downloading
    case paused
    case completed
    case failed
}

struct DownloadItem {
    let id: UUID
    let url: URL
    var state: DownloadState
    var progress: Double
    var image: UIImage?
    var resumeData: Data?

    init(url: URL) {
        self.id = UUID()
        self.url = url
        self.state = .queued
        self.progress = 0.0
        self.image = nil
        self.resumeData = nil
    }
}
