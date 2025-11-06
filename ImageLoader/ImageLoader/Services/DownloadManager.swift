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
	
	private(set) var backgroundSession: URLSession!
	
	private var taskById: [UUID: URLSessionDownloadTask] = [:]
	private var idTaskIdentifier: [Int: UUID] = [:]
	private var resumeById: [UUID: Data] = [:]
	
	private let sync = DispatchQueue(label: "ImageLoader.DownloadManager.sync")
	
	private override init() {
		super.init()
		
		let config = URLSessionConfiguration.background(
			withIdentifier: "ImageLoader.BackgroundSession"
		)
		
		self.backgroundSession = URLSession(
			configuration: config,
			delegate: self,
			delegateQueue: nil
		)
	}
}

extension DownloadManager {
	func start(url: URL) -> DownloadModel {
		var item = DownloadModel(url: url)
		item.state = .downloading
		
		let task = backgroundSession.downloadTask(with: url)
		sync.async {
			self.taskById[item.id] = task
			self.idTaskIdentifier[task.taskIdentifier] = item.id
		}
		task.resume()
		
		return item
	}
	
	func pause(itemId: UUID) {
		let task: URLSessionDownloadTask? = sync.sync { taskById[itemId] }
		guard let task = task else { return }
		
		task.cancel(byProducingResumeData: { [weak self] data in
			guard let self = self else { return }
			self.sync.async {
				if let data = data {
					self.resumeById[itemId] = data
				}
				self.taskById[itemId] = nil
				self.idTaskIdentifier[task.taskIdentifier] = nil
			}
		})
	}
	
	func resume(itemId: UUID) {
		guard let data = sync.sync(execute: { resumeById[itemId] }) else { return }
		let task = backgroundSession.downloadTask(withResumeData: data)
		sync.async {
			self.taskById[itemId] = task
			self.idTaskIdentifier[task.taskIdentifier] = itemId
			self.resumeById[itemId] = nil
		}
		task.resume()
	}
}

private extension DownloadManager {
	func itemId(for taskIdentifier: Int) -> UUID? {
		sync.sync { idTaskIdentifier[taskIdentifier] }
	}
	
	func clearMappings(for task: URLSessionTask, itemId: UUID) {
		sync.async {
			self.taskById[itemId] = nil
			self.idTaskIdentifier[task.taskIdentifier] = nil
		}
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
		guard let itemId = itemId(for: downloadTask.taskIdentifier) else { return }
		
		let expected = totalBytesExpectedToWrite
		let value: Double
		if expected > 0 {
			let fraction = Double(totalBytesWritten) / Double(expected)
			value = min(max(fraction, 0.0), 1.0)
		} else {
			value = 0.0
		}
		
		DispatchQueue.main.async { [weak self] in
			self?.onProgress?(itemId, value)
		}
	}
	
	func urlSession(
		_ session: URLSession,
		downloadTask: URLSessionDownloadTask,
		didFinishDownloadingTo location: URL
	) {
		guard let itemId = itemId(for: downloadTask.taskIdentifier) else { return }
		
		let image = UIImage(contentsOfFile: location.path)
		
		DispatchQueue.main.async { [weak self] in
			self?.onCompletion?(itemId, image, image == nil ? "Не удалось загрузить изображение" : nil)
		}
		
		clearMappings(for: downloadTask, itemId: itemId)
	}
	
	func urlSession(
		_ session: URLSession,
		task: URLSessionTask,
		didCompleteWithError error: Error?
	) {
		guard let itemId = itemId(for: task.taskIdentifier) else { return }
		
		if let nsError = error as NSError? {
			if nsError.code == NSURLErrorCancelled {
				if let resumeData = nsError.userInfo[NSURLSessionDownloadTaskResumeData] as? Data {
					sync.async {
						self.resumeById[itemId] = resumeData
					}
				}
				clearMappings(for: task, itemId: itemId)
				return
			} else {
				DispatchQueue.main.async { [weak self] in
					self?.onCompletion?(itemId, nil, "Не удалось загрузить изображение")
				}
			}
		}
		
		clearMappings(for: task, itemId: itemId)
	}
	
	func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
		DispatchQueue.main.async { [weak self] in
			self?.backgroundSessionCompletionHandler?()
			self?.backgroundSessionCompletionHandler = nil
		}
	}
}

