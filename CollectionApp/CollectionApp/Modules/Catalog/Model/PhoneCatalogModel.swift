//
//  PhoneCatalogModel.swift
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
			features: """
 - Первое поколение: мультитач и мобильный Safari
 - Экран 3,5\" 320×480, камера 2 Мп
 - Визуальная голосовая почта, iPod + телефон + интернет
 - Без 3G и без App Store на старте (появился позже)
 """,
			imageName: "iphone-2007"
		),
		Phone(
			name: "iPhone 3G",
			releaseDate: "Июль 2008 г.",
			screenSize: "3.5\"",
			features: """
 - Поддержка 3G и GPS
 - Запуск App Store и экосистемы приложений
 - Пластиковая задняя крышка, iOS 2
 """,
			imageName: "iphone-3G"
		),
		Phone(
			name: "iPhone 4",
			releaseDate: "Июнь 2010 г.",
			screenSize: "3.5\"",
			features: """
 - Retina‑дисплей 960×640, новый «стекло + сталь» дизайн
 - A4, фронтальная камера и FaceTime
 - Основная камера 5 Мп, видео 720p
 """,
			imageName: "iphone-4"
		),
		Phone(
			name: "iPhone 4s",
			releaseDate: "Октябрь 2011 г.",
			screenSize: "3.5\"",
			features: """
 - Siri и чип A5
 - Камера 8 Мп, видео 1080p
 - Улучшенная антенна, поддержка ГЛОНАСС, iOS 5
 """,
			imageName: "iphone-4S"
		),
		Phone(
			name: "iPhone 5",
			releaseDate: "Сентябрь 2012 г.",
			screenSize: "4.0\"",
			features: """
 - Экран 4\" 1136×640 (16:9), лёгкий алюминиевый корпус
 - LTE, новый разъём Lightning
 - A6, панорамы, улучшенная фронтальная камера
 """,
			imageName: "iphone-5"
		),
		Phone(
			name: "iPhone 6",
			releaseDate: "Сентябрь 2014 г.",
			screenSize: "4.7\"",
			features: """
 - Новый дизайн и увеличенный экран 4,7\" (и 5,5\" у Plus)
 - A8, NFC и Apple Pay
 - Улучшенные камеры; OIS у версии Plus
 """,
			imageName: "iphone-6"
		),
		Phone(
			name: "iPhone SE",
			releaseDate: "Март 2016 г.",
			screenSize: "4.0\"",
			features: """
 - Компактный корпус 5s, но чип A9
 - Камера 12 Мп, 4K‑видео, Live Photos
 - Touch ID и поддержка Apple Pay
 """,
			imageName: "iphone-SE"
		),
		Phone(
			name: "iPhone 7",
			releaseDate: "Сентябрь 2016 г.",
			screenSize: "4.7\"",
			features: """
 - IP67 защита, стереодинамики, отказ от 3,5 мм
 - A10 Fusion, новая Taptic‑кнопка «Домой»
 - OIS у 7 Plus, портретный режим (Plus)
 """,
			imageName: "iphone-7"
		),
		Phone(
			name: "iPhone 8",
			releaseDate: "Сентябрь 2017 г.",
			screenSize: "4.7\"",
			features: """
 - Стеклянная задняя панель и Qi‑беспроводная зарядка
 - A11 Bionic, True Tone‑дисплей
 - Видео 4K 60 к/с, улучшенная камера и AR
 """,
			imageName: "iphone-8"
		),
		Phone(
			name: "iPhone X",
			releaseDate: "Ноябрь 2017 г.",
			screenSize: "5.8\"",
			features: """
 - OLED Super Retina, «без кнопки» и жесты
 - Face ID вместо Touch ID, вырез (notch)
 - A11 Bionic, двойная камера с OIS на обоих модулях
 """,
			imageName: "iphone-X"
		),
		Phone(
			name: "iPhone XR",
			releaseDate: "Октябрь 2018 г.",
			screenSize: "6.1\"",
			features: """
 - Liquid Retina (LCD) 6,1\", яркие цвета корпуса
 - A12 Bionic, Face ID 2‑го поколения
 - eSIM (Dual SIM), портретный режим на одинарной камере
 """,
			imageName: "iphone-XR"
		),
		Phone(
			name: "iPhone 11",
			releaseDate: "Сентябрь 2019 г.",
			screenSize: "6.1\"",
			features: """
 - Двойная камера с ультрашироким модулем
 - Ночной режим, улучшенное видео
 - A13 Bionic, увеличенная автономность
 """,
			imageName: "iphone-11"
		),
	]
}
