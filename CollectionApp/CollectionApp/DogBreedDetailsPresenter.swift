//
//  DogBreedDetailsPresenter.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import UIKit

final class DogBreedDetailsPresenter: IDogBreedDetailsPresenter, IDogBreedDetailsInteractorDelegate {
	
	private weak var view: IDogBreedDetailsView?
	
	private let interactor: IDogBreedDetailsInteractor
	private let router: IDogBreedDetailsRouter
	private let breed: DogBreed
	
	private var isAgeUnderThreeOn: Bool = true
	private var isLocationSPBOn: Bool = true
	
	private var adPhones: [Phone] = []
	
	private var loadingWorkItem: DispatchWorkItem?
	private var isWaitingForDog: Bool = false
	
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
		
		interactor.loadDog(ageUnderThree: isAgeUnderThreeOn, inSPB: isLocationSPBOn)
		
		interactor.loadRandomAdPhones(count: 3)
	}
	
	func ageUnderThreeToggled(isOn: Bool) {
		isAgeUnderThreeOn = isOn
		scheduleDelayedIndicator()
		interactor.loadDog(ageUnderThree: isAgeUnderThreeOn, inSPB: isLocationSPBOn)
	}
	
	func locationSPBToggled(isOn: Bool) {
		isLocationSPBOn = isOn
		scheduleDelayedIndicator()
		interactor.loadDog(ageUnderThree: isAgeUnderThreeOn, inSPB: isLocationSPBOn)
	}
	
	func didTapAdPhone(at index: Int) {
		guard adPhones.indices.contains(index) else { return }
		let phone = adPhones[index]
		router.openPhoneDetails(phone)
	}
	
	private func scheduleDelayedIndicator() {
		loadingWorkItem?.cancel()
		isWaitingForDog = true
		
		let work = DispatchWorkItem { [weak self] in
			guard let self, self.isWaitingForDog else { return }
			self.view?.showLoading(true)
		}
		loadingWorkItem = work
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: work)
	}
		
	func didLoadDog(option: DogOption, breed: DogBreed) {
		isWaitingForDog = false
		loadingWorkItem?.cancel()
		view?.showLoading(false)
		
		view?.setBreedTitle(breed.name)
		view?.setDogName(option.name)
		view?.setDescriptionText(option.description)
		view?.setDogImage(UIImage(named: option.imageName))
		view?.setPriceText("Цена: ₽\(option.price)")
	}
	
	func didFailToLoadDog() {
		isWaitingForDog = false
		loadingWorkItem?.cancel()
		view?.showLoading(false)
		
		view?.setDogName("")
		view?.setDescriptionText("Нет подходящей собачки под выбранные параметры.")
		view?.setDogImage(nil)
		view?.setPriceText("")
	}
	
	func didLoadAdPhones(_ phones: [Phone]) {
		self.adPhones = phones
		view?.setAdPhones(phones)
	}
}

