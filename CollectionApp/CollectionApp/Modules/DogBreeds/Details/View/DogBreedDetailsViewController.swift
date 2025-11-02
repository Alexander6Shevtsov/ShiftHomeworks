//
//  DogBreedDetailsViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//
//

import UIKit

final class DogBreedDetailsViewController: UIViewController, IDogBreedDetailsView {
	
	var presenter: IDogBreedDetailsPresenter!
	
	private let activityIndicator = UIActivityIndicatorView(style: .large)
	
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
	
	private let mainStack = UIStackView()
	private let filtersStack = UIStackView()
	private let ageRow = UIStackView()
	private let locationRow = UIStackView()
	
	private var adPhones: [Phone] = []
	
	private lazy var phonesCollectionView: UICollectionView = {
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
		activityIndicator.hidesWhenStopped = true
		activityIndicator.isUserInteractionEnabled = false
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(activityIndicator)
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.alwaysBounceVertical = true
		scrollView.alwaysBounceHorizontal = false
		contentView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		mainStack.axis = .vertical
		mainStack.spacing = 12
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(mainStack)
		
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
		
		ageRow.axis = .horizontal
		ageRow.alignment = .center
		ageRow.spacing = 8
		ageRow.translatesAutoresizingMaskIntoConstraints = false
		ageCheckbox.translatesAutoresizingMaskIntoConstraints = false
		ageLabel.translatesAutoresizingMaskIntoConstraints = false
		ageRow.addArrangedSubview(ageCheckbox)
		ageRow.addArrangedSubview(ageLabel)
		
		locationRow.axis = .horizontal
		locationRow.alignment = .center
		locationRow.spacing = 8
		locationRow.translatesAutoresizingMaskIntoConstraints = false
		locationCheckbox.translatesAutoresizingMaskIntoConstraints = false
		locationLabel.translatesAutoresizingMaskIntoConstraints = false
		locationRow.addArrangedSubview(locationCheckbox)
		locationRow.addArrangedSubview(locationLabel)
		
		filtersStack.axis = .vertical
		filtersStack.spacing = 12
		filtersStack.translatesAutoresizingMaskIntoConstraints = false
		filtersStack.addArrangedSubview(ageRow)
		filtersStack.addArrangedSubview(locationRow)
		
		mainStack.addArrangedSubview(nameLabel)
		mainStack.addArrangedSubview(imageView)
		mainStack.addArrangedSubview(priceLabel)
		mainStack.addArrangedSubview(descriptionLabel)
		mainStack.addArrangedSubview(filtersStack)
		mainStack.addArrangedSubview(phonesCollectionView)
	}
	
	private func configureCheckboxButton(_ button: UIButton) {
		button.setImage(UIImage(systemName: "square"), for: .normal)
		button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
		button.tintColor = .systemGreen
	}
	
	private func setupLayout() {
		let safe = view.safeAreaLayoutGuide
		
		let nameLineHeight = ceil(nameLabel.font.lineHeight)
		let priceLineHeight = ceil(priceLabel.font.lineHeight)
		
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			
			scrollView.topAnchor.constraint(equalTo: safe.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
			
			mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
			
			ageCheckbox.widthAnchor.constraint(equalToConstant: 28),
			ageCheckbox.heightAnchor.constraint(equalToConstant: 28),
			locationCheckbox.widthAnchor.constraint(equalToConstant: 28),
			locationCheckbox.heightAnchor.constraint(equalToConstant: 28),
			
			nameLabel.heightAnchor.constraint(equalToConstant: nameLineHeight),
			priceLabel.heightAnchor.constraint(equalToConstant: priceLineHeight),
			
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.6),
			imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 180),
			
			phonesCollectionView.heightAnchor.constraint(equalToConstant: 130),
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
		if isLoading {
			view.bringSubviewToFront(activityIndicator)
			activityIndicator.startAnimating()
		} else {
			activityIndicator.stopAnimating()
		}
	}
	
	func setBreedTitle(_ title: String) {
		self.title = title
	}
	
	func displayDog(_ viewModel: DogDetailsViewModel) {
		nameLabel.text = viewModel.name
		descriptionLabel.text = viewModel.description
		priceLabel.text = viewModel.priceText
		if let imageName = viewModel.imageName {
			imageView.image = UIImage(named: imageName)
		} else {
			imageView.image = nil
		}
	}
	
	func setAgeUnderThreeChecked(_ isOn: Bool) {
		ageCheckbox.isSelected = isOn
	}
	
	func setLocationSPBChecked(_ isOn: Bool) {
		locationCheckbox.isSelected = isOn
	}
	
	func setAdPhones(_ phones: [Phone]) {
		self.adPhones = phones
		phonesCollectionView.reloadData()
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
		guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
			let height = collectionView.bounds.height - 8
			return CGSize(width: 120, height: height)
		}
		let columns: CGFloat = 3
		let sectionInsets = flow.sectionInset
		let spacing = flow.minimumInteritemSpacing
		let availableWidth = collectionView.bounds.width
		- sectionInsets.left - sectionInsets.right
		- spacing * (columns - 1)
		let itemWidth = floor(availableWidth / columns)
		let itemHeight = collectionView.bounds.height - 8
		return CGSize(width: itemWidth, height: itemHeight)
	}
}

