//
//  CompaniesViewController.swift
//  CoreCompany
//
//  Created by Alexander Shevtsov on 07.11.2025.
//

import UIKit

final class CompaniesViewController: UITableViewController {
	
	private var items: [Company] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupNavigationBar()
		reloadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		reloadData()
	}
	
	private func setupNavigationBar() {
		title = "Компании"
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(addTapped)
		)
	}
	
	@objc
	private func addTapped() {
		DataStore.createCompany()
		reloadData()
	}
	
	private func reloadData() {
		items = DataStore.fetchCompanies()
		tableView.reloadData()
	}
	
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		return items.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		let reuseId = "CompanyCell"
		let cell = tableView.dequeueReusableCell(
			withIdentifier: reuseId
		) ?? UITableViewCell(style: .default, reuseIdentifier: reuseId)
		let company = items[indexPath.row]
		var content = cell.defaultContentConfiguration()
		content.text = company.name
		content.textProperties.numberOfLines = 1
		cell.contentConfiguration = content
		return cell
	}
	
	override func tableView(
		_ tableView: UITableView,
		commit editingStyle: UITableViewCell.EditingStyle,
		forRowAt indexPath: IndexPath
	) {
		guard editingStyle == .delete else { return }
		let company = items[indexPath.row]
		DataStore.deleteCompany(company)
		reloadData()
	}
	
	override func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
		tableView.deselectRow(at: indexPath, animated: true)
		let company = items[indexPath.row]
		let controller = EmployeesViewController(company: company)
		navigationController?.pushViewController(controller, animated: true)
	}
}
