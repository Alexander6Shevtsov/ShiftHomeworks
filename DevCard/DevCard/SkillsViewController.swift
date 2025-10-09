//
//  SkillsViewController.swift
//  DevCard
//
//  Created by Alexander Shevtsov on 06.10.2025.
//

import UIKit

final class SkillsViewController: UIViewController {
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Навыки разработчика"
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.textAlignment = .center
		return label
	}()
	
	private let experienceLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 20, weight: .regular)
		return label
	}()
	
	private let languagesLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 20, weight: .regular)
		return label
	}()
	
	private let resultsLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 20, weight: .regular)
		return label
	}()
	
	private let skillsStack = UIStackView()
	
	private let skills = DevelopSkills(
		experienceYears: 1,
		languages: "Swift",
		internshipResults: "Хочу заполнить пробелы, углубить знания, получить оффер и на практике применять и улучшать навыки."
	)
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.tabBarItem = UITabBarItem(
			title: "Навыки",
			image: UIImage(systemName: "hammer.fill"),
			tag: 0
		)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setup()
		configure(skills)
	}
	
	private func setup() {
		view.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		skillsStack.axis = .vertical
		skillsStack.spacing = 16
		[experienceLabel, languagesLabel, resultsLabel].forEach(skillsStack.addArrangedSubview)
		
		view.addSubview(skillsStack)
		skillsStack.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			
			skillsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
			skillsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			skillsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
		])
	}
	
	private func configure(_ skills: DevelopSkills) {
		experienceLabel.text = "Опыт: \(skills.experienceYears) год"
		languagesLabel.text = "Языки: \(skills.languages)"
		resultsLabel.text = "Ожидания: \(skills.internshipResults)"
	}
}
