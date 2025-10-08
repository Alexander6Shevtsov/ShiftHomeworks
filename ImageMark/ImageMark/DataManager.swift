//
//  DataManager.swift
//  ImageMark
//
//  Created by Alexander Shevtsov on 30.09.2025.
//

import Foundation

final class DataManager<Element> {
	
	private var storage: [Element] = []
	private let queue = DispatchQueue(label: "DataManagerQueue")
	
	func append(_ item: Element) {
		queue.sync { storage.append(item) }
	}
	
	func items() -> [Element] {
		queue.sync { storage }
	}
	
	func clear() {
		queue.sync { storage.removeAll(keepingCapacity: false) }
	}
}
