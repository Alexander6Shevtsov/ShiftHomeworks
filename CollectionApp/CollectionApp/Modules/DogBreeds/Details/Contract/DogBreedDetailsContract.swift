//
//  DogBreedDetailsContract.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 02.11.2025.
//

import Foundation

struct DogDetailsViewModel {
	let name: String
	let description: String
	let priceText: String
	let imageName: String?
}

protocol IDogBreedDetailsView: AnyObject {
	func showLoading(_ isLoading: Bool)
	func setBreedTitle(_ title: String)
	func displayDog(_ viewModel: DogDetailsViewModel)
	func setAgeUnderThreeChecked(_ isOn: Bool)
	func setLocationSPBChecked(_ isOn: Bool)
	func setAdPhones(_ phones: [Phone])
}

protocol IDogBreedDetailsPresenter: AnyObject {
	func viewDidLoad()
	func ageUnderThreeToggled(isOn: Bool)
	func locationSPBToggled(isOn: Bool)
	func didTapAdPhone(at index: Int)
}
