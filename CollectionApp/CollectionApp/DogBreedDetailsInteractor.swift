//
//  DogBreedDetailsInteractor.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//


import Foundation

protocol IDogBreedDetailsInteractorDelegate: AnyObject {
	func didLoadDog(option: DogOption, breed: DogBreed)
	func didFailToLoadDog()
	func didLoadAdPhones(_ phones: [Phone])
}

protocol IDogBreedDetailsInteractor: AnyObject {
	func loadDefaultDog()
	func loadDog(ageUnderThree: Bool, inSPB: Bool)
	func loadRandomAdPhones(count: Int)
}

final class DogBreedDetailsInteractor: IDogBreedDetailsInteractor {
	
	weak var delegate: IDogBreedDetailsInteractorDelegate?
	private let breed: DogBreed
	
	init(breed: DogBreed) {
		self.breed = breed
	}
	
	func loadDefaultDog() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
			guard let self else { return }
			guard let option = self.breed.variants.randomElement() else {
				self.delegate?.didFailToLoadDog()
				return
			}
			self.delegate?.didLoadDog(option: option, breed: self.breed)
		}
	}
	
	func loadDog(ageUnderThree: Bool, inSPB: Bool) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
			guard let self else { return }
			
			let locationMatches: (DogOption) -> Bool = { option in
				inSPB ? (option.location == .spb) : true
			}
			let ageMatches: (DogOption) -> Bool = { option in
				ageUnderThree ? (option.ageYears <= 3) : true
			}
			
			if let matched = self.breed.variants.first(where: { locationMatches($0) && ageMatches($0) }) {
				self.delegate?.didLoadDog(option: matched, breed: self.breed)
			} else {
				self.delegate?.didFailToLoadDog()
			}
		}
	}
	
	func loadRandomAdPhones(count: Int) {
		let phones = Array(PhoneCatalog.phones.shuffled().prefix(count))
		delegate?.didLoadAdPhones(phones)
	}
}

