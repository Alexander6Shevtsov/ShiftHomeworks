//
//  main.swift
//  ImageMark
//
//  Created by Alexander Shevtsov on 30.09.2025.
//

import Foundation

struct ProcessedImage {
	let fileName: String
	let status: String
}

final class ImageService {
	
	private let storage = DataManager<ProcessedImage>()
	
	// кэш результатов по имени файла
	private var cache: [String: ProcessedImage] = [:]
	private let cacheQueue = DispatchQueue(label: "CacheQueue")
	
	func processImagesInParallel(
		imageNames: [String],
		completion: @escaping (_ results: [ProcessedImage], _ duration: TimeInterval) -> Void
	) {
		let group = DispatchGroup()
		let startTime = CFAbsoluteTimeGetCurrent()
		
		storage.clear()
		
		for fileName in imageNames {
			group.enter()
			
			// Проверка кэша
			var cached: ProcessedImage?
			cacheQueue.sync {
				cached = cache[fileName]
			}
			if let cached {
				storage.append(cached)
				group.leave()
				continue
			}
			
			// Загрузка и водяной знак
			loadImage(fileName: fileName) { [weak self] loadedImage in
				guard let self else {
					group.leave()
					return
				}
				self.addWatermark(loadedImage) { [weak self] markedImage in
					guard let self else {
						group.leave()
						return
					}
					self.cacheQueue.sync { [fileName, markedImage] in
						self.cache[fileName] = markedImage
					}
					self.storage.append(markedImage)
					group.leave()
				}
			}
		}
		
		group.notify(queue: .main) { [storage] in
			let duration = CFAbsoluteTimeGetCurrent() - startTime
			completion(storage.items(), duration)
		}
	}
	
	// MARK: - Имитация загрузки
	private func loadImage(
		fileName: String,
		completion: @escaping (ProcessedImage) -> Void
	) {
		let prepared = ProcessedImage(fileName: fileName, status: "loaded")
		DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
			completion(prepared)
		}
	}
	
	// MARK: - Имитация нанесения водяного знака
	private func addWatermark(
		_ image: ProcessedImage,
		completion: @escaping (ProcessedImage) -> Void
	) {
		let marked = ProcessedImage(fileName: image.fileName, status: "watermarked")
		DispatchQueue.global(qos: .userInitiated).async {
			completion(marked)
		}
	}
}

let imageService = ImageService()
let imageNames = ["image1.png", "image2.jpg", "image3.jpg", "image4.jpg"]

DispatchQueue.main.async {
	print("Начинаем загружать и обрабатывать изображения!")
	
	imageService.processImagesInParallel(imageNames: imageNames) { results, duration in
		print("Асинхронно обработано изображений: \(results.count)")
		print("Результаты: \(results.map { $0.fileName })")
		print(String(format: "Процесс занял: %.0f сек", duration))
		
		exit(EXIT_SUCCESS)
	}
}

RunLoop.main.run()
