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

let imageService = ImageService()
let imageNames = ["image1.png", "image2.jpg", "image3.jpg", "image4.jpg"]

DispatchQueue.main.async {
	imageService.processImagesInParallel(imageNames: imageNames) { result in
		print("Асинхронно обработано изображений: \(result.count)")
		print("Результаты: \(results.map { $0.fileName })")
	}
	
	print("Начинаем загружать и обрабатывать изображения")
}

