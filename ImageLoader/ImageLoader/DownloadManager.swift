//
//  DownloadManager.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 04.11.2025.
//

import UIKit

final class DownloadManager: NSObject {
	static let shared = DownloadManager()
	
	private lazy var session: URLSession = {
		let config = URLSessionConfiguration.background(withIdentifier: "ImageLoader.DownloadManager")
		config.waitsForConnectivity = true
		return URLSession(configuration: config, delegate: self, delegateQueue: nil)
	}()
	
	private var tasks: [URL: URLSessionDownloadTask] = [:]
	private var progresses: [URL: (Double) -> Void] = [:]
	private var completions: [URL: (UIImage?, String?) -> Void] = [:]
	private var resumeDataDict: [URL: Data] = [:]
	
	private override init() {	super.init() }
	
	func startDownload(
		for url: URL,
		progress: @escaping (Double) -> Void,
		completion: @escaping (UIImage?, String?) -> Void
	) {
		if tasks[url] != nil { return } // !
		
		let task = session.downloadTask(with: url)
		tasks[url] = task
		progresses[url] = progress
		completions[url] = completion
		task.resume()
	}
	
	func pauseDownload(for url: URL) {
		guard let task = tasks[url] else { return }
		task.cancel { [weak self] resumeData in
			self?.resumeDataDict[url] = resumeData
			self?.tasks[url] = nil
		}
	}
	
	func resumeDownload(
		for url: URL,
		progress: @escaping (Double) -> Void,
		completion: @escaping (UIImage?, String?) -> Void
	) {
		guard let resumeData = resumeDataDict[url] else { return }
		let task = session.downloadTask(withResumeData: resumeData)
		tasks[url] = task
		progresses[url] = progress
		completions[url] = completion
		task.resume()
		resumeDataDict[url] = nil
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
		guard let url = downloadTask.originalRequest?.url,
			  let progressBlock = progresses[url] else { return }
		let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
		DispatchQueue.main.async {
			progressBlock(progress)
		}
	}
	
	func urlSession(
		_ session: URLSession,
		downloadTask: URLSessionDownloadTask,
		didFinishDownloadingTo location: URL
	) {
		guard let url = downloadTask.originalRequest?.url,
			  let completion = completions[url] else { return }
		let data = try? Data(contentsOf: location)
		let image = data.flatMap(UIImage.init(data:))
		DispatchQueue.main.async {
			completion(image, image == nil ? "Не удалось загрузить" : nil)
		}
		tasks[url] = nil
		progresses[url] = nil
		completions[url] = nil
	}
	
	func urlSession(
		_ session: URLSession,
		task: URLSessionTask,
		didCompleteWithError error: Error?
	) {
		guard let url = task.originalRequest?.url else { return }
		if let error = error as NSError?, error.code != NSURLErrorCancelled {
			let completion = completions[url]
			DispatchQueue.main.async {
				completion?(nil, error.localizedDescription)
			}
			tasks[url] = nil
			progresses[url] = nil
			completions[url] = nil
		}
	}
}
