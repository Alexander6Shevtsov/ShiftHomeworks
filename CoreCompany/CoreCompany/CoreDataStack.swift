//
//  CoreDataStack.swift
//  CoreCompany
//
//  Created by Alexander Shevtsov on 08.11.2025.
//

import CoreData

final class CoreDataStack {
	
	static let shared = CoreDataStack()
	
	private init() {}
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Model")
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				NSLog("Persistent store load error: \(error), \(error.userInfo)")
				assertionFailure("Failed to load persistent store")
			}
		}
		container.viewContext.automaticallyMergesChangesFromParent = true
		container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		return container
	}()
	
	var viewContext: NSManagedObjectContext {
		persistentContainer.viewContext
	}
	
	func saveContext() {
		let context = viewContext
		guard context.hasChanges else { return }
		do {
			try context.save()
		} catch {
			let nsError = error as NSError
			NSLog("Save error: \(nsError), \(nsError.userInfo)")
		}
	}
}

