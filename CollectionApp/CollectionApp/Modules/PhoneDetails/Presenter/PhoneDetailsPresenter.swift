//
//  PhoneDetailsPresenter.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 17.10.2025.
//

import Foundation

protocol PhoneDetailsView: AnyObject {
	func display(title: String)
	func displayReleaseDate(text: String)
	func displayScreenSize(text: String)
	func setMoreButtonTitle(title: String)
	func showInnovations(featuresText: String)
}

final class PhoneDetailsPresenter {
	
	private weak var view: PhoneDetailsView?
	private let phone: Phone
	
	init(view: PhoneDetailsView, phone: Phone) {
		self.view = view
		self.phone = phone
	}
	
	func viewDidLoad() {
		view?.display(title: phone.name)
		view?.displayReleaseDate(text: phone.releaseDate)
		view?.displayScreenSize(text: phone.screenSize)
		view?.setMoreButtonTitle(title: "Инновации")
	}
	
	func didTapMore() {
		view?.showInnovations(featuresText: phone.features)
	}
}
