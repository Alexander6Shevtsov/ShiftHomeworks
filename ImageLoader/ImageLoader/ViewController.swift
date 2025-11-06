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
		title = "Загрузка изображений"
		
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

extension ViewController: UITableViewDelegate {
	
}

extension ViewController: UITableViewDataSource {
	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
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
			cell.accessoryView = nil
		} else if let error = download.error {
			config.secondaryText = "Ошибка: \(error)"
			config.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .headline)
			config.image = nil
			cell.accessoryView = nil
		} else {
			config.secondaryText = String(format: "Прогресс: %.0f%%", download.progress * 100)
			config.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .headline)
			config.image = nil
			let button = UIButton(type: .system)
			let title = download.isPaused ? "Продолжить" : "Пауза"
			button.setTitle(title, for: .normal)
			button.sizeToFit()
			button.tag = indexPath.row
			button.addTarget(self, action: #selector(togglePauseResume(_:)), for: .touchUpInside)
			cell.accessoryView = button
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
			  let url = URL(string: text),
			  let comps = URLComponents(url: url, resolvingAgainstBaseURL: false),
			  let scheme = comps.scheme?.lowercased(),
			  (scheme == "http" || scheme == "https"),
			  comps.host?.isEmpty == false else {
			showAlert(title: "Ошибка", message: "Введите корректный URL (http/https).")
			return
		}
		
		if downloads.contains(where: { $0.url == url }) {
			showAlert(title: "Уже добавлено", message: "Загрузка по этому URL уже есть в списке.")
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

@objc private extension ViewController {
	func togglePauseResume(_ sender: UIButton) {
		let row = sender.tag
		guard row < downloads.count else { return }
		let download = downloads[row]
		let url = download.url
		
		if download.isPaused {
			downloads[row].isPaused = false
			DownloadManager.shared.resumeDownload(
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
		} else {
			downloads[row].isPaused = true
			DownloadManager.shared.pauseDownload(for: url)
		}
		tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
	}
	
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}
}
