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
	func setAdPhones(_ phones: [Phone])
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
	
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	
	private let nameLabel = UILabel()
	private let imageView = UIImageView()
	private let priceLabel = UILabel()
	private let descriptionLabel = UILabel()
	
	private let ageCheckbox = UIButton(type: .system)
	private let ageLabel = UILabel()
	private let locationCheckbox = UIButton(type: .system)
	private let locationLabel = UILabel()
	
	private var adPhones: [Phone] = []
	private lazy var adsCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumInteritemSpacing = 8
		layout.minimumLineSpacing = 8
		layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .clear
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(AdPhoneCell.self, forCellWithReuseIdentifier: AdPhoneCell.reuseID)
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupUI()
		setupLayout()
		presenter.viewDidLoad()
	}
	
	private func setupUI() {
		activity.hidesWhenStopped = true
		activity.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(activity)
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		contentView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		nameLabel.font = .preferredFont(forTextStyle: .title2)
		nameLabel.textColor = .label
		nameLabel.numberOfLines = 1
		
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 12
		imageView.backgroundColor = .secondarySystemBackground
		
		priceLabel.font = .preferredFont(forTextStyle: .headline)
		priceLabel.textColor = .label
		priceLabel.numberOfLines = 1
		
		descriptionLabel.font = .preferredFont(forTextStyle: .body)
		descriptionLabel.textColor = .label
		descriptionLabel.numberOfLines = 0
		
		configureCheckboxButton(ageCheckbox)
		ageLabel.text = "Возраст: до 3-х лет"
		ageLabel.font = .preferredFont(forTextStyle: .body)
		ageLabel.textColor = .label
		
		configureCheckboxButton(locationCheckbox)
		locationLabel.text = "Локация: СПБ"
		locationLabel.font = .preferredFont(forTextStyle: .body)
		locationLabel.textColor = .label
		
		ageCheckbox.addTarget(self, action: #selector(ageCheckboxTapped), for: .touchUpInside)
		locationCheckbox.addTarget(self, action: #selector(locationCheckboxTapped), for: .touchUpInside)
		
		[
			nameLabel,
			imageView,
			priceLabel,
			descriptionLabel,
			ageCheckbox, ageLabel,
			locationCheckbox, locationLabel,
			adsCollectionView
		].forEach { sub in
			sub.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(sub)
		}
	}
	
	private func configureCheckboxButton(_ button: UIButton) {
		button.setImage(UIImage(systemName: "square"), for: .normal)
		button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
		button.tintColor = .systemBlue
		button.contentHorizontalAlignment = .leading
	}
	
	private func setupLayout() {
		let safe = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			
			scrollView.topAnchor.constraint(equalTo: safe.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
			
			nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			
			imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.6),
			
			priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
			priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			
			descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			
			ageCheckbox.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
			ageCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			ageCheckbox.widthAnchor.constraint(equalToConstant: 28),
			ageCheckbox.heightAnchor.constraint(equalToConstant: 28),
			
			ageLabel.centerYAnchor.constraint(equalTo: ageCheckbox.centerYAnchor),
			ageLabel.leadingAnchor.constraint(equalTo: ageCheckbox.trailingAnchor, constant: 8),
			ageLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
			
			locationCheckbox.topAnchor.constraint(equalTo: ageCheckbox.bottomAnchor, constant: 12),
			locationCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			locationCheckbox.widthAnchor.constraint(equalToConstant: 28),
			locationCheckbox.heightAnchor.constraint(equalToConstant: 28),
			
			locationLabel.centerYAnchor.constraint(equalTo: locationCheckbox.centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: locationCheckbox.trailingAnchor, constant: 8),
			locationLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
			
			adsCollectionView.topAnchor.constraint(equalTo: locationCheckbox.bottomAnchor, constant: 20),
			adsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			adsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			adsCollectionView.heightAnchor.constraint(equalToConstant: 110),
			adsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
		])
	}
	
	@objc private func ageCheckboxTapped() {
		ageCheckbox.isSelected.toggle()
		presenter.ageUnderThreeToggled(isOn: ageCheckbox.isSelected)
	}
	
	@objc private func locationCheckboxTapped() {
		locationCheckbox.isSelected.toggle()
		presenter.locationSPBToggled(isOn: locationCheckbox.isSelected)
	}
	
	func showLoading(_ isLoading: Bool) {
		isLoading ? activity.startAnimating() : activity.stopAnimating()
	}
	
	func setBreedTitle(_ title: String) {
		self.title = title
	}
	
	func setDogName(_ name: String) {
		nameLabel.text = name
	}
	
	func setDescriptionText(_ text: String) {
		descriptionLabel.text = text
	}
	
	func setDogImage(_ image: UIImage?) {
		imageView.image = image
	}
	
	func setPriceText(_ text: String) {
		priceLabel.text = text
	}
	
	func setAgeUnderThreeChecked(_ isOn: Bool) {
		ageCheckbox.isSelected = isOn
	}
	
	func setLocationSPBChecked(_ isOn: Bool) {
		locationCheckbox.isSelected = isOn
	}
	
	func setAdPhones(_ phones: [Phone]) {
		self.adPhones = phones
		adsCollectionView.reloadData()
	}
}

extension DogBreedDetailsViewController:
	UICollectionViewDataSource,
	UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return adPhones.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: AdPhoneCell.reuseID,
			for: indexPath
		) as? AdPhoneCell else {
			return UICollectionViewCell()
		}
		let phone = adPhones[indexPath.item]
		cell.configure(name: phone.name, imageName: phone.imageName)
		return cell
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		collectionView.deselectItem(at: indexPath, animated: true)
		presenter.didTapAdPhone(at: indexPath.item)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let height = collectionView.bounds.height - 8
		return CGSize(width: 120, height: height)
	}
}
