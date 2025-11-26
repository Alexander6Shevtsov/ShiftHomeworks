//
//  PhoneDetailsViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 12.10.2025.
//

import UIKit

final class PhoneDetailsViewController: UIViewController, PhoneDetailsView {
	
	var presenter: PhoneDetailsPresenter!
	
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	
	private let stackView = UIStackView()
	private let imageView = UIImageView()
	private let titleLabel = UILabel()
	private let releaseDateTitle = UILabel()
	private let releaseDateValue = UILabel()
	private let screenSizeTitle = UILabel()
	private let screenSizeValue = UILabel()
	private let moreButton = UIButton(type: .system)
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupView()
		setupLayout()
		presenter.viewDidLoad()
	}
	
	private func setupView() {
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.alwaysBounceVertical = true
		scrollView.alwaysBounceHorizontal = false
		view.addSubview(scrollView)
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(contentView)
		
		stackView.axis = .vertical
		stackView.spacing = 12
		stackView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stackView)
		
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.backgroundColor = .secondarySystemBackground
		imageView.layer.cornerRadius = 12
		
		titleLabel.font = .preferredFont(forTextStyle: .title2)
		titleLabel.textColor = .label
		
		releaseDateTitle.text = "Дата выхода:"
		releaseDateTitle.font = .preferredFont(forTextStyle: .headline)
		releaseDateTitle.textColor = .secondaryLabel
		
		releaseDateValue.font = .preferredFont(forTextStyle: .body)
		releaseDateValue.textColor = .label
		
		screenSizeTitle.text = "Размер экрана:"
		screenSizeTitle.font = .preferredFont(forTextStyle: .headline)
		screenSizeTitle.textColor = .secondaryLabel
		
		screenSizeValue.font = .preferredFont(forTextStyle: .body)
		screenSizeValue.textColor = .label
		
		moreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
		
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(releaseDateTitle)
		stackView.addArrangedSubview(releaseDateValue)
		stackView.addArrangedSubview(screenSizeTitle)
		stackView.addArrangedSubview(screenSizeValue)
		stackView.addArrangedSubview(moreButton)
	}
	
	private func setupLayout() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		let padding: CGFloat = 16
		let safe = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: safe.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
			
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
			
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
		])
	}
	
	@objc private func moreTapped() {
		presenter.didTapMore()
	}
	
	func display(title: String) {
		self.title = title
		titleLabel.text = title
	}
	
	func displayReleaseDate(text: String) {
		releaseDateValue.text = text
	}
	
	func displayScreenSize(text: String) {
		screenSizeValue.text = text
	}
	
	func setMoreButtonTitle(title: String) {
		moreButton.setTitle(title, for: .normal)
	}
	
	func showInnovations(featuresText: String) {
		let innovationView = InnovationsViewController(featuresText: featuresText)
		let navController = UINavigationController(rootViewController: innovationView)
		present(navController, animated: true)
	}
	
	func displayImage(named: String) {
		imageView.image = UIImage(named: named)
	}
}
