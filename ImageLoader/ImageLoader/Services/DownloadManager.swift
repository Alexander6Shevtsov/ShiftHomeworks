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
	private var idByTaskIdentifier: [Int: UUID] = [:]
	private var resumeById: [UUID: Data] = [:]
	
	private override init() {
		super.init()
		
		let config = URLSessionConfiguration.background(withIdentifier: "ImageLoader.BackgroundSession")
		var headers = config.httpAdditionalHeaders ?? [:]
		headers["Accept-Encoding"] = "identity"
		config.httpAdditionalHeaders = headers
		
		self.backgroundSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
	}
}

extension DownloadManager {
	func start(url: URL) -> DownloadModel {
		var item = DownloadModel(url: url)
		item.state = .downloading
		
		let task = backgroundSession.downloadTask(with: url)
		taskById[item.id] = task
		idByTaskIdentifier[task.taskIdentifier] = item.id
		task.resume()
		
		return item
	}
	
	func pause(itemId: UUID) {
		guard let task = taskById[itemId] else { return }
		
		(task as URLSessionDownloadTask).cancel(byProducingResumeData: { [weak self] data in
			guard let self = self else { return }
			if let data = data {
				self.resumeById[itemId] = data
			}
			self.taskById[itemId] = nil
			self.idByTaskIdentifier[task.taskIdentifier] = nil
		})
	}
	
	func resume(itemId: UUID) {
		guard let data = resumeById[itemId] else { return }
		let task = backgroundSession.downloadTask(withResumeData: data)
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
		
		let unknown = NSURLSessionTransferSizeUnknown
		let expected = [
			totalBytesExpectedToWrite,
			downloadTask.countOfBytesExpectedToReceive,
			downloadTask.response?.expectedContentLength
		]
			.compactMap { $0 }
			.first(where: { $0 > 0 && $0 != unknown })
		
		let progress = expected.map { Double(totalBytesWritten) / Double($0) } ?? 0.0
		
		DispatchQueue.main.async { [weak self] in
			self?.onProgress?(itemId, min(max(progress, 0.0), 1.0))
		}
	}
	
	func urlSession(
		_ session: URLSession,
		downloadTask: URLSessionDownloadTask,
		didFinishDownloadingTo location: URL
	) {
		guard let itemId = idByTaskIdentifier[downloadTask.taskIdentifier] else { return }
		
		let image = UIImage(contentsOfFile: location.path)
		
		DispatchQueue.main.async { [weak self] in
			self?.onCompletion?(itemId, image, image == nil ? "Не удалось загрузить изображение" : nil)
		}
		
		taskById[itemId] = nil
		idByTaskIdentifier[downloadTask.taskIdentifier] = nil
	}
	
	func urlSession(
		_ session: URLSession,
		task: URLSessionTask,
		didCompleteWithError error: Error?
	) {
		guard let itemId = idByTaskIdentifier[task.taskIdentifier] else {
			return
		}
		
		if let nsError = error as NSError? {
			if nsError.code == NSURLErrorCancelled {
				if let resumeData = nsError.userInfo[NSURLSessionDownloadTaskResumeData] as? Data {
					resumeById[itemId] = resumeData
				}
				taskById[itemId] = nil
				idByTaskIdentifier[task.taskIdentifier] = nil
				return
			} else {
				DispatchQueue.main.async { [weak self] in
					self?.onCompletion?(itemId, nil, nsError.localizedDescription)
				}
			}
		}
		
		taskById[itemId] = nil
		idByTaskIdentifier[task.taskIdentifier] = nil
	}
	
	func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
		DispatchQueue.main.async { [weak self] in
			self?.backgroundSessionCompletionHandler?()
			self?.backgroundSessionCompletionHandler = nil
		}
	}
}
