//
//  InnovationsViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 12.10.2025.
//

import UIKit

final class InnovationsViewController: UIViewController {
	
	private let label = UILabel()
	private let viewModel: InnovationsViewModel
	
	init(featuresText: String) {
		self.viewModel = InnovationsViewModel(featuresText: featuresText)
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = "Инновации"
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(closeTapped)
		)
		
		label.text = viewModel.text
		label.font = .preferredFont(forTextStyle: .body)
		label.textColor = .label
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(label)
		
		let inset: CGFloat = 16
		let safe = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: safe.topAnchor, constant: inset),
			label.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: inset),
			label.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -inset),
			label.bottomAnchor.constraint(lessThanOrEqualTo: safe.bottomAnchor, constant: -inset)
		])
		
		viewModel.onTextChanged = { [weak self] newText in
			self?.label.text = newText
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.startUpdating()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		viewModel.stopUpdating()
	}
	
	@objc private func closeTapped() {
		dismiss(animated: true)
	}
}

