//
//  CatalogViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 08.10.2025.
//

import UIKit

final class CatalogViewController: UIViewController {
	
	private let phones = PhoneCatalog.phones
	
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 8
		layout.minimumLineSpacing = 8
		layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
		
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.backgroundColor = .systemBackground
		collection.alwaysBounceVertical = true
		collection.dataSource = self
		collection.delegate = self
		collection.register(PhoneCell.self, forCellWithReuseIdentifier: PhoneCell.reuseID)
		collection.allowsSelection = true
		return collection
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Catalog"
		view.backgroundColor = .systemBackground
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		collectionView.collectionViewLayout.invalidateLayout()
	}
}

extension CatalogViewController: UICollectionViewDataSource {
	
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		phones.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: PhoneCell.reuseID,
			for: indexPath
		) as! PhoneCell
		cell.configure(phones[indexPath.item])
		return cell
	}
}

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collection: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
			return CGSize(width: 120, height: 160)
		}
		
		let isLandscape = view.bounds.width > view.bounds.height
		let columns: CGFloat = isLandscape ? 3 : 1
		let insert = layout.sectionInset.left + layout.sectionInset.right
		let spacing = layout.minimumInteritemSpacing * (columns - 1)
		let availableWidth = collection.bounds.width - insert - spacing
		let itemWidth = floor(availableWidth / columns)
		let itemHeight = itemWidth + 36
		return CGSize(width: itemWidth, height: itemHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let phone = phones[indexPath.item]
		let details = PhoneDetailsViewController(phone: phone)
		navigationController?.pushViewController(details, animated: true)
	}
}
