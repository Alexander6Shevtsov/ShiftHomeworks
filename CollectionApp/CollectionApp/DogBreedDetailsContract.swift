//
//  DogBreedDetailsContract.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 02.11.2025.
//

import UIKit

protocol IDogBreedDetailsView: AnyObject {
	func showLoading(_ isLoading: Bool)
	func setBreedTitle(_ title: String)
	func setDogName(_ name: String)
	func setDescriptionText(_ text: String)
	func setDogImage(named: String?)
	func setPriceText(_ text: String)
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
