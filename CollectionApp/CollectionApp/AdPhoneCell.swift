//
//  AdPhoneCell.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 28.10.2025.
//

import UIKit

final class AdPhoneCell: UICollectionViewCell {
	static let reuseID = "AdPhoneCell"
	
	private let imageView = UIImageView()
	private let titleLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
		titleLabel.text = nil
	}
	
	func configure(name: String, imageName: String) {
		titleLabel.text = name
		imageView.image = UIImage(named: imageName)
	}
	
	private func setup() {
		contentView.backgroundColor = .secondarySystemBackground
		contentView.layer.cornerRadius = 10
		contentView.layer.masksToBounds = true
		
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		
		titleLabel.font = .preferredFont(forTextStyle: .footnote)
		titleLabel.textAlignment = .center
		titleLabel.textColor = .label
		titleLabel.numberOfLines = 2
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(imageView)
		contentView.addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
			
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
			titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -6)
		])
	}
}

