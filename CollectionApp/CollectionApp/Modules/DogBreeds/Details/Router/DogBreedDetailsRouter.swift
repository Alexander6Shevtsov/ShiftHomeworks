//
//  DogBreedDetailsRouter.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import UIKit

protocol IDogBreedDetailsRouter: AnyObject {
	func openPhoneDetails(_ phone: Phone)
}

final class DogBreedDetailsRouter: IDogBreedDetailsRouter {
	
	weak var viewController: UIViewController?
	
	func openPhoneDetails(_ phone: Phone) {
		let detailsVC = PhoneDetailsViewController()
		let presenter = PhoneDetailsPresenter(view: detailsVC, phone: phone)
		detailsVC.presenter = presenter
		viewController?.navigationController?.pushViewController(detailsVC, animated: true)
	}
}
