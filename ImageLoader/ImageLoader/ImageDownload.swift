//
//  ImageDownload.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 03.11.2025.
//

import UIKit

struct ImageDownload {
	let url: URL
	var image: UIImage?
	var error: String?
	var progress: Double
	var resumeData: Data?
	var isPaused: Bool
	
	init(url: URL) {
		self.url = url
		self.image = nil
		self.error = nil
		self.progress = 0
		self.resumeData = nil
		self.isPaused = false
	}
}
