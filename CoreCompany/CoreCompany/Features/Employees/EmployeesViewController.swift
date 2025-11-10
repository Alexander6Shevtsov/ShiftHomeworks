//
//  EmployeesViewController.swift
//  CoreCompany
//
//  Created by Alexander Shevtsov on 09.11.2025.
//

import UIKit

final class EmployeesViewController: UITableViewController {
	
	private let company: Company
	private var employees: [Employee] = []
	
	init(company: Company) {
		self.company = company
		super.init(style: .plain)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupNavigationBar()
		reloadData()
	}
	
	private func setupNavigationBar() {
		title = "Сотрудники компании " + (company.name ?? "")
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(addTapped)
		)
	}
	
	@objc
	private func addTapped() {
		DataStore.createEmployee(for: company)
		reloadData()
	}
	
	private func reloadData() {
		employees = DataStore.fetchEmployees(for: company)
		tableView.reloadData()
	}
	
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		return employees.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		let reuseId = "EmployeeCell"
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseId)
		?? UITableViewCell(style: .default, reuseIdentifier: reuseId)
		let employee = employees[indexPath.row]
		var content = cell.defaultContentConfiguration()
		content.text = employee.name
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
		let employee = employees[indexPath.row]
		DataStore.deleteEmployee(employee)
		reloadData()
	}
	
	override func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
