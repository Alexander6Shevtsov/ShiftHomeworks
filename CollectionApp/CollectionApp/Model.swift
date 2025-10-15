//
//  Model.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 09.10.2025.
//

import Foundation

struct Phone {
	let name: String
	let releaseDate: String
	let screenSize: String
	let features: String
	let imageName: String
}

enum PhoneCatalog {
	static let phones: [Phone] = [
		Phone(
			name: "iPhone",
			releaseDate: "Июнь 2007 г.",
			screenSize: "3.5\"",
			features: "Мультитач, Safari, изменил представление о телефоне",
			imageName: "iphone-2007"
		),
		Phone(
			name: "iPhone 3G",
			releaseDate: "Июль 2008 г.",
			screenSize: "3.5\"",
			features: "3G, App Store, GPS",
			imageName: "iphone-3G"
		),
		Phone(
			name: "iPhone 4",
			releaseDate: "Июнь 2010 г.",
			screenSize: "3.5\"",
			features: "Retina‑дисплей, FaceTime, новый дизайн",
			imageName: "iphone-4"
		),
		Phone(
			name: "iPhone 4s",
			releaseDate: "Октябрь 2011 г.",
			screenSize: "3.5\"",
			features: "Siri, камера 8 Мп, A5",
			imageName: "iphone-4S"
		),
		Phone(
			name: "iPhone 5",
			releaseDate: "Сентябрь 2012 г.",
			screenSize: "4.0\"",
			features: "Экран 4\", LTE, Lightning",
			imageName: "iphone-5"
		),
		Phone(
			name: "iPhone 6",
			releaseDate: "Сентябрь 2014 г.",
			screenSize: "4.7\"",
			features: "Бóльший экран, NFC, Apple Pay",
			imageName: "iphone-6"
		),
		Phone(
			name: "iPhone SE",
			releaseDate: "Март 2016 г.",
			screenSize: "4.0\"",
			features: "Компактный, A9, Touch ID",
			imageName: "iphone-SE"
		),
		Phone(
			name: "iPhone 7",
			releaseDate: "Сентябрь 2016 г.",
			screenSize: "4.7\"",
			features: "IP67, стереодинамики, без 3,5 мм",
			imageName: "iphone-7"
		),
		Phone(
			name: "iPhone 8",
			releaseDate: "Сентябрь 2017 г.",
			screenSize: "4.7\"",
			features: "Стекло, Qi‑зарядка, True Tone, A11",
			imageName: "iphone-8"
		),
		Phone(
			name: "iPhone X",
			releaseDate: "Ноябрь 2017 г.",
			screenSize: "5.8\"",
			features: "Face ID, OLED, жесты",
			imageName: "iphone-X"
		),
		Phone(
			name: "iPhone XR",
			releaseDate: "Октябрь 2018 г.",
			screenSize: "6.1\"",
			features: "Liquid Retina, A12, eSIM",
			imageName: "iphone-XR"
		),
		Phone(
			name: "iPhone 11",
			releaseDate: "Сентябрь 2019 г.",
			screenSize: "6.1\"",
			features: "Двойная камера, Ночной режим, A13",
			imageName: "iphone-11"
		),
	]
}
