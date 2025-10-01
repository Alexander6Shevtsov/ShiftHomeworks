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
	func processImagesInParallel(
		imageNames: [String],
		completion: @escaping ([ProcessedImage]) -> Void
	) {
		let group = DispatchGroup()
		let storage = DataManager<ProcessedImage>()
		
		for fileName in imageNames {
			group.enter()
			loadImage(fileName: fileName) { loadedImage in
				addWatermark(loadedImage) { markedImage in
					storage.append(markedImage)
					group.leave()
				}
			}
		}
		
		group.notify(queue: .main) {
			completion(storage.items())
		}
	}
}

// MARK: - Имитация загрузки
func loadImage(fileName: String, completion: @escaping (ProcessedImage) -> Void) {
	let prepared = ProcessedImage(fileName: fileName, status: "loaded")
	DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
		completion(prepared)
	}
}

// MARK: - Имитация нанесения водяного знака
func addWatermark(_ image: ProcessedImage, completion: @escaping (ProcessedImage) -> Void) {
	let marked = ProcessedImage(fileName: image.fileName, status: "watermarked")
	DispatchQueue.global(qos: .userInitiated).async {
		completion(marked)
	}
}

let imageService = ImageService()
let imageNames = ["image1.png", "image2.jpg", "image3.jpg", "image4.jpg"]
let startTime = CFAbsoluteTimeGetCurrent()

DispatchQueue.main.async {
	print("Начинаем загружать и обрабатывать изображения!")
	
	imageService.processImagesInParallel(imageNames: imageNames) { results in
		print("Асинхронно обработано изображений: \(results.count)")
		print("Результаты: \(results.map { $0.fileName })")
		
		let spent = CFAbsoluteTimeGetCurrent() - startTime
		print(String(format: "Процесс занял: %.0f сек", spent))
		
		exit(EXIT_SUCCESS)
	}
}

RunLoop.main.run()
