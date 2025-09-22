//
//  main.swift
//  CarRegistry
//
//  Created by Alexander Shevtsov on 19.09.2025.
//

import Foundation

// MARK: - Models
enum Body: Int, CaseIterable {
	case sedan = 1
	case hatchback = 2
	case coupe = 3
	case suv = 4
	case wagon = 5
	
	var title: String {
		switch self {
		case .sedan: return "Седан"
		case .hatchback: return "Хэтчбек"
		case .coupe: return "Купе"
		case .suv: return "Внедорожник"
		case .wagon: return "Универсал"
		}
	}
}

struct Car {
	let manufacturer: String
	let model: String
	let body: Body
	let yearOfIssue: Int?
	let carNumber: String?
}

// MARK: - Storage
var cars: [Car] = []

// MARK: - Menu Types
enum MenuAction: Int, CaseIterable {
	case addCar = 1
	case listCars = 2
	case listByBody = 3
	case exit = 0
	
	var title: String {
		switch self {
		case .addCar: return "Добавить автомобиль"
		case .listCars: return "Список автомобилей"
		case .listByBody: return "Список по типу кузова"
		case .exit: return "Выход"
		}
	}
	
	var displayLine: String { "\(rawValue) — \(title)" }
	
	func perform() -> Bool {
		switch self {
		case .addCar:
			performAddCar()
			return false
		case .listCars:
			printCarsList()
			return false
		case .listByBody:
			printCarsByBody()
			return false
		case .exit:
			print("\nДо новых встреч!")
			return true
		}
	}
}

// MARK: - Console
func readLineTrimmed() -> String {
	(readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
}

func getString(_ text: String) -> String {
	while true {
		print(text, terminator: " ")
		let value = readLineTrimmed()
		if value.isEmpty {
			print("Повторите ввод:")
		} else {
			return value
		}
	}
}

func getInt(_ text: String) -> Int {
	while true {
		print(text, terminator: " ")
		let raw = readLineTrimmed()
		if let value = Int(raw) {
			return value
		}
		print("Повторите ввод.")
	}
}

// MARK: - Input
func getBody() -> Body {
	while true {
		print("\nВыберите тип кузова:")
		for body in Body.allCases {
			print("\(body.rawValue) — \(body.title)")
		}
		let number = getInt("Введите номер:")
		if let body = Body(rawValue: number) {
			return body
		}
		print("\nНеверный номер, повторите ввод.")
	}
}

func getCurrentYear() -> Int {
	Calendar.current.component(.year, from: Date())
}

func getYear(_ text: String) -> Int? {
	let minYear = 1900
	let maxYear = getCurrentYear()
	while true {
		print(text, terminator: " ")
		let raw = readLineTrimmed()
		if raw.isEmpty {
			return nil
		}
		if let value = Int(raw), (minYear...maxYear).contains(value) {
			return value
		}
		print("Введите год:")
	}
}

// MARK: - Operations
func performAddCar() {
	let manufacturer = getString("Производитель:")
	let model = getString("Модель:")
	let body = getBody()
	let yearValue = getYear("Год выпуска:")
	print("Гос. номер:", terminator: " ")
	let numberText = readLineTrimmed()
	var carNumber: String? = nil
	if numberText.isEmpty == false {
		carNumber = numberText
	}
	
	cars.append(
		Car(
			manufacturer: manufacturer,
			model: model,
			body: body,
			yearOfIssue: yearValue,
			carNumber: carNumber
		)
	)
	
	print("\nАвтомобиль добавлен")
}


// MARK: - Output
func printCar(_ car: Car) {
	print("\nПроизводитель: \(car.manufacturer)")
	print("Модель: \(car.model)")
	print("Тип кузова: \(car.body.title)")
	print("Год выпуска: \(car.yearOfIssue.map(String.init) ?? "-")")
	if let carNumber = car.carNumber {
		if carNumber.isEmpty == false {
			print("Гос. номер: \(carNumber)")
		}
	}
}

func printCars(_ cars: [Car]) {
	for car in cars {
		printCar(car)
	}
}

func printCarsList() {
	if cars.isEmpty {
		print("\nСписок пуст")
		return
	}
	printCars(cars)
}

func printCarsByBody() {
	let chosenBody = getBody()
	let filtered = cars.filter { $0.body == chosenBody }
	if filtered.isEmpty {
		print("\nАвтомобили с типом кузова «\(chosenBody.title)» не найдены.")
		return
	}
	printCars(filtered)
}

// MARK: - Menu
func showMenu() {
	print("\nМеню:")
	for action in MenuAction.allCases {
		print(action.displayLine)
	}
}

func readMenuCommand() -> MenuAction {
	while true {
		let number = getInt("Введите номер и нажмите Enter:")
		if let action = MenuAction(rawValue: number) {
			return action
		}
		print("\nНеверный номер, повторите ввод.")
	}
}

func run() {
	while true {
		showMenu()
		let action = readMenuCommand()
		if action.perform() { break }
	}
}

run()
