//
//  DogBreedDetailsPresenter.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import Foundation

@MainActor
final class DogBreedDetailsPresenter: IDogBreedDetailsPresenter, IDogBreedDetailsInteractorDelegate {
	
	private weak var view: IDogBreedDetailsView?
	
	private let interactor: IDogBreedDetailsInteractor
	private let router: IDogBreedDetailsRouter
	private let breed: DogBreed
	
	private var isAgeUnderThreeOn: Bool = true
	private var isLocationSPBOn: Bool = true
	
	private var adPhones: [Phone] = []
	
	init(
		view: IDogBreedDetailsView,
		interactor: IDogBreedDetailsInteractor,
		router: IDogBreedDetailsRouter,
		breed: DogBreed
	) {
		self.view = view
		self.interactor = interactor
		self.router = router
		self.breed = breed
	}
	
	func viewDidLoad() {
		view?.setBreedTitle(breed.name)
		
		if let anyOption = breed.variants.randomElement() {
			isAgeUnderThreeOn = anyOption.ageYears <= 3
			isLocationSPBOn = (anyOption.location == .spb)
		}
		
		view?.setAgeUnderThreeChecked(isAgeUnderThreeOn)
		view?.setLocationSPBChecked(isLocationSPBOn)
		
		view?.showLoading(true)
		
		interactor.loadDog(ageUnderThree: isAgeUnderThreeOn, inSPB: isLocationSPBOn)
		interactor.loadRandomPhones(count: 3)
	}
	
	func ageUnderThreeToggled(isOn: Bool) {
		isAgeUnderThreeOn = isOn
		view?.showLoading(true)
		interactor.loadDog(ageUnderThree: isAgeUnderThreeOn, inSPB: isLocationSPBOn)
	}
	
	func locationSPBToggled(isOn: Bool) {
		isLocationSPBOn = isOn
		view?.showLoading(true)
		interactor.loadDog(ageUnderThree: isAgeUnderThreeOn, inSPB: isLocationSPBOn)
	}
	
	func didTapAdPhone(at index: Int) {
		guard adPhones.indices.contains(index) else { return }
		let phone = adPhones[index]
		router.openPhoneDetails(phone)
	}
	
	func didLoadDog(option: DogOption, breed: DogBreed) {
		view?.showLoading(false)
		view?.setBreedTitle(breed.name)
		
		let viewModel = DogDetailsViewModel(
			name: option.name,
			description: option.description,
			priceText: "Цена: ₽\(option.price)",
			imageName: option.imageName
		)
		view?.displayDog(viewModel)
	}
	
	func didFailToLoadDog() {
		view?.showLoading(false)
		
		let viewModel = DogDetailsViewModel(
			name: "",
			description: "Нет подходящей собачки под выбранные параметры.",
			priceText: "",
			imageName: nil
		)
		view?.displayDog(viewModel)
	}
	
	func didLoadAdPhones(_ phones: [Phone]) {
		self.adPhones = phones
		view?.setAdPhones(phones)
	}
}

