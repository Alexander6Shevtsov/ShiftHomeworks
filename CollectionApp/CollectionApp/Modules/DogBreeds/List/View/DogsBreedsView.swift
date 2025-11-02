//
//  DogsBreedsView.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import UIKit

final class DogsBreedsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	static let preferredHeight: CGFloat = 176 + 24
	
	var onSelectBreed: ((DogBreed) -> Void)?
	
	private var breeds: [DogBreed] = []
	
	private lazy var breedsCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumInteritemSpacing = 8
		layout.minimumLineSpacing = 8
		layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .clear
		collectionView.showsHorizontalScrollIndicator = true
		collectionView.alwaysBounceHorizontal = true
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		collectionView.register(
			DogBreedCell.self,
			forCellWithReuseIdentifier: DogBreedCell.reuseID
		)
		return collectionView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setBreeds(_ breeds: [DogBreed]) {
		self.breeds = breeds
		breedsCollectionView.reloadData()
	}
		
	private func setupView() {
		backgroundColor = .systemBackground
		addSubview(breedsCollectionView)
	}
	
	private func setupLayout() {
		NSLayoutConstraint.activate([
			breedsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
			breedsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			breedsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			breedsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
			breedsCollectionView.heightAnchor.constraint(equalToConstant: 176)
		])
	}
		
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return breeds.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: DogBreedCell.reuseID,
			for: indexPath
		) as? DogBreedCell else {
			return UICollectionViewCell()
		}
		let breed = breeds[indexPath.item]
		cell.configure(breed: breed)
		return cell
	}
		
	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let breed = breeds[indexPath.item]
		onSelectBreed?(breed)
	}
		
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let height = collectionView.bounds.height
		return CGSize(width: 140, height: height - 4)
	}
}
