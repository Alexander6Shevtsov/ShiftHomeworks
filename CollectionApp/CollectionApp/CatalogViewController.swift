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
		layout.minimumLineSpacing = 6
		layout.sectionInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
		layout.sectionInsetReference = .fromSafeArea
		layout.estimatedItemSize = .zero
		
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
		title = "Каталог"
		view.backgroundColor = .systemBackground
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		let safe = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
		])
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		collectionView.collectionViewLayout.invalidateLayout()
	}
	
	override func viewWillTransition(
		to size: CGSize,
		with coordinator: UIViewControllerTransitionCoordinator
	) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition: { _ in
			self.collectionView.collectionViewLayout.invalidateLayout()
		})
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
		
		let safeFrame = view.safeAreaLayoutGuide.layoutFrame
		let isLandscape = safeFrame.width > safeFrame.height
		let columns: CGFloat = isLandscape ? 3 : 1
		
		let horizontalInsets = layout.sectionInset.left + layout.sectionInset.right
		let interitemSpacing = layout.minimumInteritemSpacing * (columns - 1)
		let availableWidth = collection.bounds.inset(by: collection.adjustedContentInset).width - horizontalInsets - interitemSpacing
		let itemWidth = floor(availableWidth / columns)
		
		let rows: CGFloat = isLandscape ? 1 : 2
		let verticalInsets = layout.sectionInset.top + layout.sectionInset.bottom
		let lineSpacing = layout.minimumLineSpacing * (rows - 1)
		let availableHeight = collection.bounds.inset(by: collection.adjustedContentInset).height - verticalInsets - lineSpacing
		let itemHeight = floor(availableHeight / rows)
		
		return CGSize(width: itemWidth, height: itemHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let phone = phones[indexPath.item]
		let details = PhoneDetailsViewController(phone: phone)
		navigationController?.pushViewController(details, animated: true)
	}
}
