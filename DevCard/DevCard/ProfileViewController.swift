//
//  ProfileViewController.swift
//  DevCard
//
//  Created by Alexander Shevtsov on 02.10.2025.
//

import UIKit

final class ProfileViewController: UIViewController {
	
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var fullNameLabel: UILabel!
	@IBOutlet weak var educationLabel: UILabel!
	@IBOutlet weak var cityLabel: UILabel!
	
	private let person = Person(
		fullName: "Александр Шевцов",
		education: "Государственный политехнический колледж",
		city: "Санкт-Петербург",
		photo: "avatar"
	)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		configureView(person)
		
		view.layoutIfNeeded()
		avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
		avatarImageView.clipsToBounds = true
	}
	
	private func setupUI() {
		avatarImageView.contentMode = .scaleAspectFill
	}
	
	private func configureView(_ person: Person) {
		avatarImageView.image = UIImage(named: person.photo)
		fullNameLabel.text = "\(person.fullName)"
		educationLabel.text = "Образование: \(person.education)"
		cityLabel.text = "Город: \(person.city)"
	}
}
