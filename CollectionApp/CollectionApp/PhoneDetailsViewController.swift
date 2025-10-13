//
//  PhoneDetailsViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 12.10.2025.
//

import UIKit

final class PhoneDetailsViewController: UIViewController {
	
	private let phone: Phone
	
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	private let stackView = UIStackView()
	
	private let titleLabel = UILabel()
	private let releaseDateTitle = UILabel()
	private let releaseDateValue = UILabel()
	private let screenSizeTitle = UILabel()
	private let screenSizeValue = UILabel()
	private let moreButton = UIButton(type: .system)

	init(phone: Phone) {
		self.phone = phone
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupHierarchy()
		setupLayout()
		configure(with: phone)
	}
	
	private func setupView() {
		view.backgroundColor = .systemBackground
		title = phone.name
	}
	
	// MARK: - Построение иерархии
	
	private func setupHierarchy() {
		
		stackView.axis = .vertical
		stackView.spacing = 12
		stackView.alignment = .fill
		stackView.distribution = .fill
		
		titleLabel.font = .preferredFont(forTextStyle: .title2)
		titleLabel.textColor = .label
		titleLabel.numberOfLines = 0
		
		releaseDateTitle.text = "Дата выхода:"
		releaseDateTitle.font = .preferredFont(forTextStyle: .headline)
		releaseDateTitle.textColor = .secondaryLabel
		releaseDateTitle.numberOfLines = 1
		
		releaseDateValue.font = .preferredFont(forTextStyle: .body)
		releaseDateValue.textColor = .label
		releaseDateValue.numberOfLines = 1
		
		screenSizeTitle.text = "Размер экрана:"
		screenSizeTitle.font = .preferredFont(forTextStyle: .headline)
		screenSizeTitle.textColor = .secondaryLabel
		screenSizeTitle.numberOfLines = 1
		
		screenSizeValue.font = .preferredFont(forTextStyle: .body)
		screenSizeValue.textColor = .label
		screenSizeValue.numberOfLines = 1
		
		moreButton.setTitle("Подробнее", for: .normal)
		moreButton.addTarget(
			self,
			action: #selector(moreTapped),
			for: .touchUpInside
		)
		
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		contentView.addSubview(stackView)
		
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(releaseDateTitle)
		stackView.addArrangedSubview(releaseDateValue)
		stackView.addArrangedSubview(screenSizeTitle)
		stackView.addArrangedSubview(screenSizeValue)
		stackView.addArrangedSubview(moreButton)
	}
	
	private func setupLayout() {
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		contentView.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
		])
		
		let padding: CGFloat = 16
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
		])
	}
	
	private func configure(with phone: Phone) {
		titleLabel.text = phone.name
		releaseDateValue.text = phone.releaseDate
		screenSizeValue.text = phone.screenSize
	}
	
	@objc private func moreTapped() {
		let modal = InnovationsViewController(featuresText: phone.features)
		let nav = UINavigationController(rootViewController: modal)
		nav.modalPresentationStyle = .automatic
		present(nav, animated: true)                                   
	}
}
