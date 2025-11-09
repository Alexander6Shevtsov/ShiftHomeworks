//
//  DataStore.swift
//  CoreCompany
//
//  Created by Alexander Shevtsov on 09.11.2025.
//

import CoreData

enum DataStore {
	
	static func fetchCompanies() -> [Company] {
		let context = CoreDataStack.shared.viewContext
		let request: NSFetchRequest<Company> = Company.fetchRequest()
		
		do {
			let item = try context.fetch(request)
			let sorted = item.sorted {
				let left = $0.employees?.count ?? 0
				let right = $1.employees?.count ?? 0
				return left > right
			}
			return sorted
		} catch {
			NSLog("Failed to fetch companies: \(error)")
			return []
		}
	}
	
	@discardableResult
	static func createCompany() -> Company? {
		let context = CoreDataStack.shared.viewContext
		let company = Company(context: context)
		company.id = UUID().uuidString
		company.name = UUID().uuidString
		CoreDataStack.shared.saveContext()
		return company
	}
	
	static func deleteCompany(_ company: Company) {
		let context = CoreDataStack.shared.viewContext
		context.delete(company)
		CoreDataStack.shared.saveContext()
	}
	
	static func fetchEmployees(for company: Company) -> [Employee] {
		let context = CoreDataStack.shared.viewContext
		let request: NSFetchRequest<Employee> = Employee.fetchRequest()
		request.predicate = NSPredicate(format: "company == %@", company)
		request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
		do {
			return try context.fetch(request)
		} catch {
			NSLog("Fetch employees error: \(error)")
			return []
		}
	}
	
	@discardableResult
	static func createEmployee(for company: Company) -> Employee? {
		let context = CoreDataStack.shared.viewContext
		let employee = Employee(context: context)
		employee.id = UUID().uuidString
		employee.name = UUID().uuidString
		employee.company = company
		CoreDataStack.shared.saveContext()
		return employee
	}
	
	static func deleteEmployee(_ employee: Employee) {
		let context = CoreDataStack.shared.viewContext
		context.delete(employee)
		CoreDataStack.shared.saveContext()
	}
}
