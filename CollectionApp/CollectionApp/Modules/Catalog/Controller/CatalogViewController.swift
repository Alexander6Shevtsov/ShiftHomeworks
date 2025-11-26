//
//  CatalogViewController.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 08.10.2025.
//

import UIKit

final class CatalogViewController: UIViewController {
	
	private let phones = PhoneCatalog.phones
	
	private var catalogView: CatalogView {
		guard let view = self.view as? CatalogView else {
			fatalError("Expected CatalogView")
		}
		return view
	}
	
	override func loadView() {
		view = CatalogView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Каталог"
		
		catalogView.collectionView.dataSource = self
		catalogView.collectionView.delegate = self
	}
	
	override func viewWillTransition(
		to size: CGSize,
		with coordinator: UIViewControllerTransitionCoordinator
	) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition: { [weak self] _ in
			guard let self else { return }
			self.catalogView.collectionView.collectionViewLayout.invalidateLayout()
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
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: PhoneCell.reuseID,
			for: indexPath
		) as? PhoneCell else {
			assertionFailure("Failed to dequeue PhoneCell")
			return UICollectionViewCell()
		}
		cell.setupCell(phone: phones[indexPath.item])
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
		let interItemSpacing = layout.minimumInteritemSpacing * (columns - 1)
		let availableWidth = collection.bounds.inset(
			by: collection.adjustedContentInset
		).width - horizontalInsets - interItemSpacing
		let itemWidth = floor(availableWidth / columns)
		
		let rows: CGFloat = isLandscape ? 1 : 2
		let verticalInsets = layout.sectionInset.top + layout.sectionInset.bottom
		let lineSpacing = layout.minimumLineSpacing * (rows - 1)
		let availableHeight = collection.bounds.inset(
			by: collection.adjustedContentInset
		).height - verticalInsets - lineSpacing
		let itemHeight = floor(availableHeight / rows)
		
		return CGSize(width: itemWidth, height: itemHeight)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let phone = phones[indexPath.item]
		
		let detailsVC = PhoneDetailsViewController()
		let presenter = PhoneDetailsPresenter(view: detailsVC, phone: phone)
		detailsVC.presenter = presenter
		
		navigationController?.pushViewController(detailsVC, animated: true)
	}
}
