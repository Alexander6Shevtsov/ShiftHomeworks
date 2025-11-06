//
//  DownloadManager.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 04.11.2025.
//

import UIKit

final class DownloadManager: NSObject {
	
	static let shared = DownloadManager()
	
	var onProgress: ((UUID, Double) -> Void)?
	var onCompletion: ((UUID, UIImage?, String?) -> Void)?
	
	var backgroundSessionCompletionHandler: (() -> Void)?
	
	private lazy var session: URLSession = {
		let config = URLSessionConfiguration.background(withIdentifier: "ImageLoader.BackgroundSession")
		return URLSession(configuration: config, delegate: self, delegateQueue: nil)
	}()
	
	private var taskById: [UUID: URLSessionDownloadTask] = [:]
	private var idByTaskIdentifier: [Int: UUID] = [:]
	private var resumeById: [UUID: Data] = [:]
	
	private override init() { super.init() }
}

extension DownloadManager {
	func start(url: URL) -> DownloadItem {
		var item = DownloadItem(url: url)
		item.state = .downloading
		
		let task = session.downloadTask(with: url)
		taskById[item.id] = task
		idByTaskIdentifier[task.taskIdentifier] = item.id
		task.resume()
		
		DispatchQueue.main.async { [weak self] in
			self?.onProgress?(item.id, 0.0)
		}
		return item
	}
	
	func pause(itemId: UUID) {
		guard let task = taskById[itemId] else { return }
		task.cancel { [weak self] data in
			guard let self = self else { return }
			if let data = data {
				self.resumeById[itemId] = data
			}
			self.taskById[itemId] = nil
			self.idByTaskIdentifier[task.taskIdentifier] = nil
		}
	}
	
	func resume(itemId: UUID) {
		guard let data = resumeById[itemId] else { return }
		let task = session.downloadTask(withResumeData: data)
		taskById[itemId] = task
		idByTaskIdentifier[task.taskIdentifier] = itemId
		resumeById[itemId] = nil
		task.resume()
	}
}

extension DownloadManager: URLSessionDownloadDelegate {
	func urlSession(
		_ session: URLSession,
		downloadTask: URLSessionDownloadTask,
		didWriteData bytesWritten: Int64,
		totalBytesWritten: Int64,
		totalBytesExpectedToWrite: Int64
	) {
		guard let itemId = idByTaskIdentifier[downloadTask.taskIdentifier] else { return }
		let expected = totalBytesExpectedToWrite
		let progress = expected > 0 ? Double(totalBytesWritten) / Double(expected) : 0.0
		
		DispatchQueue.main.async { [weak self] in
			self?.onProgress?(itemId, progress)
		}
	}
	
	func urlSession(
		_ session: URLSession,
		downloadTask: URLSessionDownloadTask,
		didFinishDownloadingTo location: URL
	) {
		guard let itemId = idByTaskIdentifier[downloadTask.taskIdentifier] else { return }
		
		let image: UIImage?
		do {
			let data = try Data(contentsOf: location)
			image = UIImage(data: data)
		} catch {
			DispatchQueue.main.async { [weak self] in
				self?.onCompletion?(itemId, nil, "Read file error: \(error.localizedDescription)")
			}
			taskById[itemId] = nil
			idByTaskIdentifier[downloadTask.taskIdentifier] = nil
			return
		}
		
		DispatchQueue.main.async { [weak self] in
			self?.onCompletion?(itemId, image, image == nil ? "Failed to decode image" : nil)
		}
		
		taskById[itemId] = nil
		idByTaskIdentifier[downloadTask.taskIdentifier] = nil
	}
	
	func urlSession(
		_ session: URLSession,
		task: URLSessionTask,
		didCompleteWithError error: Error?
	) {
		guard let itemId = idByTaskIdentifier[task.taskIdentifier] else { return }
		
		if let err = error as NSError?, err.code != NSURLErrorCancelled {
			DispatchQueue.main.async { [weak self] in
				self?.onCompletion?(itemId, nil, err.localizedDescription)
			}
			taskById[itemId] = nil
			idByTaskIdentifier[task.taskIdentifier] = nil
		}
	}
	
	func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
		DispatchQueue.main.async { [weak self] in
			self?.backgroundSessionCompletionHandler?()
			self?.backgroundSessionCompletionHandler = nil
		}
	}
}
