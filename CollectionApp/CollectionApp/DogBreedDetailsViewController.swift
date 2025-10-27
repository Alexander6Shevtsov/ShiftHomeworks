//
//  DogBreedDetailsViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//
//

import UIKit

protocol IDogBreedDetailsView: AnyObject {
	func showLoading(_ isLoading: Bool)
	func setBreedTitle(_ title: String)
	func setDogName(_ name: String)
	func setDescriptionText(_ text: String)
	func setDogImage(_ image: UIImage?)
	func setPriceText(_ text: String)
	func setAgeUnderThreeChecked(_ isOn: Bool)
	func setLocationSPBChecked(_ isOn: Bool)
}

protocol IDogBreedDetailsPresenter: AnyObject {
	func viewDidLoad()
	func ageUnderThreeToggled(isOn: Bool)
	func locationSPBToggled(isOn: Bool)
	func didTapAdPhone(at index: Int)
}

final class DogBreedDetailsViewController: UIViewController, IDogBreedDetailsView {
	
	var presenter: IDogBreedDetailsPresenter!
	
	private let activity = UIActivityIndicatorView(style: .medium)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupMinimalUI()
		presenter.viewDidLoad()
	}
	
	private func setupMinimalUI() {
		activity.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(activity)
		NSLayoutConstraint.activate([
			activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activity.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
	func showLoading(_ isLoading: Bool) {
		isLoading ? activity.startAnimating() : activity.stopAnimating()
	}
	
	func setBreedTitle(_ title: String) {
		self.title = title
	}
	
	func setDogName(_ name: String) {
	}
	
	func setDescriptionText(_ text: String) {
	}
	
	func setDogImage(_ image: UIImage?) {
	}
	
	func setPriceText(_ text: String) {
	}
	
	func setAgeUnderThreeChecked(_ isOn: Bool) {
	}
	
	func setLocationSPBChecked(_ isOn: Bool) {
	}
}
