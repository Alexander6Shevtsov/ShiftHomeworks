//
//  DogBreedDetailsBuilder.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import UIKit

enum DogBreedDetailsBuilder {
	static func build(breed: DogBreed) -> (UIViewController & IDogBreedDetailsView) {
		let view = DogBreedDetailsViewController()
		let interactor = DogBreedDetailsInteractor(breed: breed)
		let router = DogBreedDetailsRouter()
		
		let presenter = DogBreedDetailsPresenter(
			view: view,
			interactor: interactor,
			router: router,
			breed: breed
		)
		
		view.presenter = presenter
		interactor.delegate = presenter
		router.viewController = view
		
		return view
	}
}
