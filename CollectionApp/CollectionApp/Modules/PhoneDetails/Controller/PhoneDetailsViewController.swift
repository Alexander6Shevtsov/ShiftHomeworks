//
//  PhoneDetailsViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 12.10.2025.
//

import UIKit

final class PhoneDetailsViewController: UIViewController, PhoneDetailsView {
	
	var presenter: PhoneDetailsPresenter!
	
	private let stackView = UIStackView()
	
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
		stackView.axis = .vertical
		stackView.spacing = 12
		
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
		
		moreButton.setTitle("Подробно", for: .normal)
		moreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
		
		view.addSubview(stackView)
		
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(releaseDateTitle)
		stackView.addArrangedSubview(releaseDateValue)
		stackView.addArrangedSubview(screenSizeTitle)
		stackView.addArrangedSubview(screenSizeValue)
		stackView.addArrangedSubview(moreButton)
	}
	
	private func setupLayout() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		let padding: CGFloat = 16
		let safe = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -padding),
			stackView.bottomAnchor.constraint(lessThanOrEqualTo: safe.bottomAnchor, constant: -padding)
		])
	}
	
	@objc private func moreTapped() {
		presenter.didTapMore()
	}
	
	func display(title: String) {
		self.title = title
		titleLabel.text = title
	}
	
	func displayReleaseDate(_ text: String) {
		releaseDateValue.text = text
	}
	
	func displayScreenSize(_ text: String) {
		screenSizeValue.text = text
	}
	
	func setMoreButtonTitle(_ title: String) {
		moreButton.setTitle(title, for: .normal)
	}
	
	func showInnovations(featuresText: String) {
		let innovationView = InnovationsViewController(featuresText: featuresText)
		let navigationControll = UINavigationController(rootViewController: innovationView)
		present(navigationControll, animated: true)
	}
}
