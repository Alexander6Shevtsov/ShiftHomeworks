//
//  CompaniesViewController.swift
//  CoreCompany
//
//  Created by Alexander Shevtsov on 07.11.2025.
//

import UIKit

final class CompaniesViewController: UITableViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = "Компании"
	}
	
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		0
	}
}

