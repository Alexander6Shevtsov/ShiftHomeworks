//
//  main.swift
//  CarRegistry
//
//  Created by Alexander Shevtsov on 19.09.2025.
//

import Foundation

// Хранилище
var cars: [Car] = []

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

// цикл
func runApp() {
	while true {
		printMenu()
		switch readMenuCommand() {
		case 1: addCar()
		case 2: listCars()
		case 3: listBody()
		default:
			return
		}
	}
}

func printMenu() -> Void {
	print(
		"\nМеню:\n1 — Добавить автомобиль\n2 — Список автомобилей\n3 — Список по типу кузова\nВведите номер команды и нажмите Enter:"
	)
}

func readMenuCommand() -> Int {
	while true {
		if let value = Int(readLine() ?? ""), (0...3).contains(value) {
			return value
		}
		print("Неверная команда, повторите ввод:")
	}
}

func addCar() {
	print("Производитель:"); let manufacturer = readLine() ?? ""
	print("Модель:"); let model = readLine() ?? ""
	let body = chooseBody()
	print("Год выпуска (пусто — нет):"); let yearValue = Int(readLine() ?? "")
	print("Гос. номер (пусто — нет):"); let numberText = readLine() ?? ""
	let carNumber = numberText.isEmpty ? nil : numberText
	cars.append(
		Car(
			manufacturer: manufacturer,
			model: model,
			body: body,
			yearOfIssue: yearValue,
			carNumber: carNumber
		)
	)
}

func printCar(_ car: Car) {
	print("Производитель: \(car.manufacturer)")
	print("Модель: \(car.model)")
	print("Тип кузова: \(car.body.rawValue)")
	print("Год выпуска: \(car.yearOfIssue.map(String.init) ?? "-")")
	if let carNumber = car.carNumber, !carNumber.isEmpty {
		print("Гос. номер: \(carNumber)")
	}
}

// Список автомобилей
func listCars() {
	if cars.isEmpty {
		print("Список пуст")
		return
	}
	for car in cars {
		printCar(car)
		print()
	}
}

// Фильтр по кузову
func listBody() {
	let chosenBody = chooseBody()
	for carBody in cars where carBody.body == chosenBody {
		printCar(carBody)
		print()
	}
}

func chooseBody() -> Body {
	while true {
		print(
			"\nВыберите тип кузова:\n" +
			"1 — Седан\n" +
			"2 — Хэтчбек\n" +
			"3 — Купе\n" +
			"4 — Внедорожник\n" +
			"5 — Универсал\n" +
			"Введите номер и нажмите Enter:"
		)
		if let number = Int(readLine() ?? "") {
			switch number {
			case 1: return .sedan
			case 2: return .hatchback
			case 3: return .coupe
			case 4: return .suv
			case 5: return .wagon
			default: break
			}
		}
		print("Неверный номер, повторите ввод:")
	}
}

runApp()
