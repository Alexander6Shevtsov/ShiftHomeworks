//
//  PhoneDetailsPresenter.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 17.10.2025.
//

import Foundation

protocol PhoneDetailsView: AnyObject {
	func display(title: String)
	func displayReleaseDate(_ text: String)
	func displayScreenSize(_ text: String)
	func setMoreButtonTitle(_ title: String)
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
		view?.displayReleaseDate(phone.releaseDate)
		view?.displayScreenSize(phone.screenSize)
		view?.setMoreButtonTitle("Подробно")
	}
	
	func didTapMore() {
		view?.showInnovations(featuresText: phone.features)
	}
}
