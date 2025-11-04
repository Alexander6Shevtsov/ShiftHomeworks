//
//  ViewController.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 03.11.2025.
//

import UIKit

final class ViewController: UIViewController {
	
	private let searchBar = UISearchBar()
	private let tableView = UITableView()
	
	private var downloads: [ImageDownload] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		searchBar.placeholder = "Введите адрес изображения"
		searchBar.delegate = self
		view.addSubview(searchBar)
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			
			tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		downloads.count
	}
	
	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
		?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
		let download = downloads[indexPath.row]
		
		var config = cell.defaultContentConfiguration()
		config.text = download.url.absoluteString
		
		if let image = download.image {
			config.secondaryText = nil
			config.image = image
		} else if let error = download.error {
			config.secondaryText = "Ошибка: \(error)"
			config.image = nil
		} else {
			config.secondaryText = String(format: "Прогресс: %.0f%%", download.progress * 100)
			config.image = nil
		}
		
		cell.contentConfiguration = config
		cell.selectionStyle = .none
		return cell
	}
}

extension ViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		guard let text = searchBar.text,
			  let url = URL(string: text), UIApplication.shared.canOpenURL(url) else {
			return
		}
		
		if downloads.contains(where: { $0.url == url }) {
			return
		}
		
		let newDownload = ImageDownload(url: url)
		downloads.append(newDownload)
		let newIndex = downloads.count - 1
		tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .automatic)
		
		DownloadManager.shared.startDownload(
			for: url,
			progress: { [weak self] progress in
				guard let self = self,
					  let idx = self.downloads.firstIndex(where: { $0.url == url }) else { return }
				self.downloads[idx].progress = progress
				self.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .none)
			},
			completion: { [weak self] image, error in
				guard let self = self,
					  let idx = self.downloads.firstIndex(where: { $0.url == url }) else { return }
				self.downloads[idx].image = image
				self.downloads[idx].error = error
				self.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .automatic)
			}
		)
	}
}
