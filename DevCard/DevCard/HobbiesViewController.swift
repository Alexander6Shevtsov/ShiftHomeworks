//
//  HobbiesViewController.swift
//  DevCard
//
//  Created by Alexander Shevtsov on 06.10.2025.
//

import UIKit

final class HobbiesViewController: UIViewController {
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.tabBarItem = UITabBarItem(
			title: "Хобби",
			image: UIImage(systemName: "sparkles"),
			tag: 0
		)
	}
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Увлечения"
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.textAlignment = .center
		return label
	}()
	
	private let hobbiesStack = UIStackView()
	
	private let hobby = Hobby(hobbies: [
		"Горные лыжи",
		"Теннис большой/настольный",
		"Кроссфит",
		"Настольные игры"
	])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setup()
		configure(hobby)
	}
	
	private func setup() {
		hobbiesStack.axis = .vertical
		hobbiesStack.spacing = 16
		
		view.addSubview(titleLabel)
		view.addSubview(hobbiesStack)
		
		[titleLabel, hobbiesStack].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			
			hobbiesStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
			hobbiesStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			hobbiesStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
		])
	}
	
	private func configure(_ hobby: Hobby) {
		hobbiesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		for item in hobby.hobbies {
			let label = UILabel()
			label.numberOfLines = 0
			label.font = .systemFont(ofSize: 20, weight: .regular)
			label.text = "• \(item)"
			hobbiesStack.addArrangedSubview(label)
		}
	}
}
