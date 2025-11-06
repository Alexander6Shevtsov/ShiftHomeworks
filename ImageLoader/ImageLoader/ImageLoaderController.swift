//
//  ImageLoaderController.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 05.11.2025.
//

import UIKit

final class ImageLoaderController: UIViewController {
	
	private let searchBar = UISearchBar()
	private let tableView = UITableView(frame: .zero, style: .plain)
	
	private var items: [DownloadItem] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Загрузка изображений"
		view.backgroundColor = .systemBackground
		setupSearch()
		setupTable()
		setupCallbacks()
	}
	
	private func setupSearch() {
		searchBar.placeholder = "Введите URL адрес изображения"
		searchBar.delegate = self
		
		let textField = searchBar.searchTextField
		textField.returnKeyType = .go
		textField.enablesReturnKeyAutomatically = false
		textField.delegate = self
		
		view.addSubview(searchBar)
		searchBar.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupTable() {
		tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
		tableView.dataSource = self
		tableView.rowHeight = 80
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
	
	private func setupCallbacks() {
		DownloadManager.shared.onProgress = { [weak self] id, progress in
			guard let self = self else { return }
			if let index = self.items.firstIndex(where: { $0.id == id }) {
				self.items[index].progress = progress
				self.items[index].state = .downloading
				self.reloadRow(at: index)
			}
		}
		DownloadManager.shared.onCompletion = { [weak self] id, image, error in
			guard let self = self else { return }
			if let index = self.items.firstIndex(where: { $0.id == id }) {
				if let image = image {
					self.items[index].image = image
					self.items[index].state = .completed
					self.items[index].progress = 1.0
				} else {
					self.items[index].state = .failed
					self.showError(message: error ?? "error")
				}
				self.reloadRow(at: index)
			}
		}
	}
	
	private func reloadRow(at index: Int) {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
		}
	}
	
	private func showError(message: String) {
		DispatchQueue.main.async { [weak self] in
			let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			self?.present(alert, animated: true)
		}
	}
	
	private func performSearch(with text: String?) {
		guard let text = text, !text.isEmpty else { return }
		
		searchBar.resignFirstResponder()
		searchBar.text = nil
		searchBar.searchTextField.text = nil
		
		guard let url = URL(string: text),
			  let comps = URLComponents(url: url, resolvingAgainstBaseURL: false),
			  let scheme = comps.scheme?.lowercased(),
			  (scheme == "http" || scheme == "https"),
			  comps.host?.isEmpty == false else {
			showError(message: "Введите правильный http/https URL.")
			return
		}
		
		let item = DownloadManager.shared.start(url: url)
		
		items.append(item)
		let index = items.count - 1
		DispatchQueue.main.async { [weak self] in
			self?.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
		}
	}
}

extension ImageLoaderController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items.count
	}
	
	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: "ImageCell",
			for: indexPath
		) as? ImageCell
		let item = items[indexPath.row]
		cell?.configure(with: item)
		cell?.onPause = { [weak self] in
			guard let self = self else { return }
			DownloadManager.shared.pause(itemId: item.id)
			if let idx = self.items.firstIndex(where: { $0.id == item.id }) {
				self.items[idx].state = .paused
				self.reloadRow(at: idx)
			}
		}
		cell?.onResume = { [weak self] in
			guard let self = self else { return }
			DownloadManager.shared.resume(itemId: item.id)
			if let idx = self.items.firstIndex(where: { $0.id == item.id }) {
				self.items[idx].state = .downloading
				self.reloadRow(at: idx)
			}
		}
		return cell ?? UITableViewCell()
	}
}

extension ImageLoaderController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		performSearch(with: searchBar.text)
	}
}

extension ImageLoaderController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		performSearch(with: textField.text)
		return true
	}
}

