//
//  HobbiesViewController.swift
//  DevCard
//
//  Created by Alexander Shevtsov on 06.10.2025.
//

import UIKit

final class HobbiesViewController: UIViewController {

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Увлечения"
		label.font = .preferredFont(forTextStyle: .title2)
		label.textAlignment = .center
		label.adjustsFontForContentSizeCategory = true
		return label
	}()
	
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Чем занимаюсь помимо разработки"
		label.font = .preferredFont(forTextStyle: .subheadline)
		label.textColor = .secondaryLabel
		label.textAlignment = .center
		label.adjustsFontForContentSizeCategory = true
		return label
	}()
	
	private let hobbiesStack = UIStackView()
	
	private let hobby = Hobby(hobbies: [
		"Горные лыжи",
		"Спорт",
		"Путешествия",
		"Настольные игры"
	])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		tabBarItem = UITabBarItem(
			title: "Хобби",
			image: UIImage(systemName: "sparkles"),
			selectedImage: UIImage(systemName: "sparkles")
		)
		
		setup()
		configure(hobby)
	}
	
	private func setup() {
		hobbiesStack.axis = .vertical
		hobbiesStack.spacing = 8
		
		view.addSubview(titleLabel)
		view.addSubview(subtitleLabel)
		view.addSubview(hobbiesStack)
		
		[titleLabel, subtitleLabel, hobbiesStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			
			subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			
			hobbiesStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
			hobbiesStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			hobbiesStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
		])
	}
	
	private func configure(_ hobby: Hobby) {
		hobbiesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		for hobbyItem in hobby.hobbies {
			let label = UILabel()
			label.numberOfLines = 0
			label.font = .preferredFont(forTextStyle: .body)
			label.adjustsFontForContentSizeCategory = true
			label.text = "• \(hobbyItem)"
			hobbiesStack.addArrangedSubview(label)
		}
		
//		// нижний отступ
//		let spacer = UIView()
//		spacer.translatesAutoresizingMaskIntoConstraints = false
//		spacer.heightAnchor.constraint(equalToConstant: 20).isActive = true
//		hobbiesStack.addArrangedSubview(spacer)
	}
}
