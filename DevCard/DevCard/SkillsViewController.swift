//
//  SkillsViewController.swift
//  DevCard
//
//  Created by Alexander Shevtsov on 06.10.2025.
//

import UIKit

final class SkillsViewController: UIViewController {
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.tabBarItem = UITabBarItem(
			title: "Навыки",
			image: UIImage(systemName: "hammer.fill"),
			selectedImage: UIImage(systemName: "hammer.fill")
		)
	}
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Навыки разработчика"
		label.font = .preferredFont(forTextStyle: .title2)
		label.textAlignment = .center
		label.adjustsFontForContentSizeCategory = true
		return label
	}()
	
	private let experienceLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .preferredFont(forTextStyle: .body)
		label.adjustsFontForContentSizeCategory = true
		return label
	}()
	
	private let languagesLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .preferredFont(forTextStyle: .body)
		label.adjustsFontForContentSizeCategory = true
		return label
	}()
	
	private let resultsLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .preferredFont(forTextStyle: .body)
		label.adjustsFontForContentSizeCategory = true
		return label
	}()
	
	private let stack = UIStackView()
	
	private let skills = DevelopSkills(
		experienceYears: 1,
		languages: "Swift",
		internshipResults: "Практикуюсь в iOS, хочу прокачать архитектуры и верстку."
	)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setup()
		configure(with: skills)
	}
	
	private func setup() {
		stack.axis = .vertical
		stack.spacing = 12
		
		[titleLabel, experienceLabel, languagesLabel, resultsLabel].forEach(stack.addArrangedSubview)
		
		view.addSubview(stack)
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
		])
	}
	
	private func configure(with skills: DevelopSkills) {
		experienceLabel.text = "Опыт: \(skills.experienceYears) год"
		languagesLabel.text = "Языки: \(skills.languages)"
		resultsLabel.text = "Ожидания: \(skills.internshipResults)"
	}
}
