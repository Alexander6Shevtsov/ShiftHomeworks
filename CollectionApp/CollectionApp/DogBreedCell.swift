//
//  DogBreedCell.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import UIKit

final class DogBreedCell: UICollectionViewCell {
	
	static let reuseID = "DogBreedCell"
	
	private let nameLabel = UILabel()
	private let imageView = UIImageView()
	private let descriptionLabel = UILabel()
	
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
		nameLabel.text = nil
		imageView.image = nil
		descriptionLabel.text = nil
	}
	
	func configure(breed: DogBreed) {
		nameLabel.text = breed.name
		imageView.image = UIImage(named: breed.imageName)
		descriptionLabel.text = breed.shortDescription
	}
		
	private func setupViews() {
		contentView.backgroundColor = .secondarySystemBackground
		contentView.layer.cornerRadius = 12
		contentView.layer.masksToBounds = true
		
		nameLabel.font = .preferredFont(forTextStyle: .subheadline)
		nameLabel.textColor = .label
		nameLabel.numberOfLines = 1
		nameLabel.textAlignment = .center
		
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		
		descriptionLabel.font = .preferredFont(forTextStyle: .footnote)
		descriptionLabel.textColor = .secondaryLabel
		descriptionLabel.numberOfLines = 2
		descriptionLabel.textAlignment = .center
		
		contentView.addSubview(nameLabel)
		contentView.addSubview(imageView)
		contentView.addSubview(descriptionLabel)
		
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		imageView.translatesAutoresizingMaskIntoConstraints = false
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupLayout() {
		let imageAspect = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
		imageAspect.priority = .required
		
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
			
			imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			imageAspect,
			
			descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
			descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -6)
		])
	}
}
