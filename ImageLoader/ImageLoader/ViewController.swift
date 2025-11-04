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
		tableView.delegate = self
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

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		
		guard let text = searchBar.text,
			  let url = URL(string: text), UIApplication.shared.canOpenURL(url) else {
			return
		}
	}
}
