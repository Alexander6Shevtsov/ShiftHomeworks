//
//  PhoneCell.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 10.10.2025.
//

import UIKit

final class PhoneCell: UICollectionViewCell {
	
	static let reuseID = "PhoneCell"
	
	private let imageView = UIImageView()
	private let nameLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupCell(_ phone: Phone) {
		nameLabel.text = phone.name
		imageView.image = UIImage(named: phone.imageName)
	}
	
	private func setupViews() {
		contentView.backgroundColor = .secondarySystemBackground
		contentView.layer.cornerRadius = 12
		contentView.layer.masksToBounds = true
		
		imageView.contentMode = .scaleAspectFit
		
		nameLabel.font = .preferredFont(forTextStyle: .headline)
		nameLabel.textColor = .label
		nameLabel.numberOfLines = 1
		nameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
		
		contentView.addSubview(imageView)
		contentView.addSubview(nameLabel)
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupLayout() {
		let imageAspectConstraint = imageView.heightAnchor.constraint(
			equalTo: imageView.widthAnchor
		)
		
		imageAspectConstraint.priority = .defaultHigh
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			imageAspectConstraint,
			
			nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
		])
	}
}
