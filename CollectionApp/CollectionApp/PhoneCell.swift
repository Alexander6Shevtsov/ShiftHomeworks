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
	private let detailsLabel = UILabel()
	
	private let stack = UIStackView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
		nameLabel.text = nil
		detailsLabel.text = nil
	}
	
	func configure(_ phone: Phone) {
		nameLabel.text = phone.name
		detailsLabel.text = "\(phone.releaseDate) • \(phone.screenSize)"
		imageView.image = UIImage(named: phone.imageName)
	}
	
	private func setupViews() {
		contentView.backgroundColor = .secondarySystemBackground
		contentView.layer.cornerRadius = 12
		contentView.layer.masksToBounds = true
		
		imageView.contentMode = .scaleAspectFill
		
		nameLabel.font = .preferredFont(forTextStyle: .headline)
		nameLabel.numberOfLines = 1
		
		detailsLabel.font = .preferredFont(forTextStyle: .subheadline)
		detailsLabel.textColor = .secondaryLabel
		detailsLabel.numberOfLines = 2
		
		stack.axis = .vertical
		stack.spacing = 6
		
		contentView.addSubview(imageView)
		contentView.addSubview(stack)
		
		stack.addArrangedSubview(nameLabel)
		stack.addArrangedSubview(detailsLabel)
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		stack.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupLayout() {
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			
			stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
			stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
			
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
		])
	}
}
