//
//  CatalogView.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 16.10.2025.
//

import UIKit

final class CatalogView: UIView {
	
	let collectionView: UICollectionView
	let breedsView: DogsBreedsView
	
	override init(frame: CGRect) {
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 8
		layout.minimumLineSpacing = 6
		layout.sectionInset = UIEdgeInsets(top: 8, left: 12, bottom: 0, right: 12)
		layout.sectionInsetReference = .fromSafeArea
		layout.estimatedItemSize = .zero
		
		self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		self.breedsView = DogsBreedsView(frame: .zero)
		super.init(frame: frame)
		
		setupView()
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		backgroundColor = .systemBackground
		
		collectionView.backgroundColor = .systemBackground
		collectionView.alwaysBounceVertical = true
		collectionView.isScrollEnabled = true
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		collectionView.register(
			PhoneCell.self,
			forCellWithReuseIdentifier: PhoneCell.reuseID
		)
				
		breedsView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(collectionView)
		addSubview(breedsView)
	}
	
	private func setupLayout() {
		let safe = safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: breedsView.topAnchor),
			
			breedsView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
			breedsView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
			breedsView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
			breedsView.heightAnchor.constraint(equalToConstant: DogsBreedsView.preferredHeight)
		])
	}
}
