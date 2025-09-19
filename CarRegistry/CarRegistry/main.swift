//
//  main.swift
//  CarRegistry
//
//  Created by Alexander Shevtsov on 19.09.2025.
//

import Foundation

enum Body: String {
	case sedan = "Седан"
	case hatchback = "Хэтчбек"
	case coupe = "Купе"
	case suv = "Внедорожник"
	case wagon = "Универсал"
}

struct Car {
	let manufacturer: String
	let model: String
	let body: Body
	let yearOfIssue: Int?
	let carNumber: String?
}

func printMenu() -> Void {
	print(
		"\nМеню:\n1 — Добавить автомобиль\n2 — Список автомобилей\n3 — Список по типу кузова\nВведите номер команды и нажмите Enter:"
	)
}
