//
//  InnovationsViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 12.10.2025.
//

import UIKit

final class InnovationsViewController: UIViewController {
	
	private let featuresText: String
	private let textView = UITextView()
	
	init(featuresText: String) {
		self.featuresText = featuresText
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewDidLoadSetup()
	}
	
	private func viewDidLoadSetup() { //?????
		view.backgroundColor = .systemBackground
		title = "Иновации"
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(closeTapped)
		)
		
		textView.text = featuresText
		textView.font = .preferredFont(forTextStyle: .body)
		textView.isEditable = false
		textView.alwaysBounceVertical = true
		textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
		textView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(textView)
		
		NSLayoutConstraint.activate([
			textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	@objc private func closeTapped() {
		dismiss(animated: true)           
	}
}
