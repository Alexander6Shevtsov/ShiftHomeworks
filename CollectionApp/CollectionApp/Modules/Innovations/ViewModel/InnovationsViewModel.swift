//
//  InnovationsViewModel.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 17.10.2025.
//

import Foundation

final class InnovationsViewModel {
	
	private(set) var text: String
	var onTextChanged: ((String) -> Void)?
	
	private let allLines: [String]
	private var updateTask: Task<Void, Never>?
	private var revealedCount: Int = 0
	
	init(featuresText: String) {
		let lines = featuresText
			.components(separatedBy: .newlines)
			.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
			.filter { $0.isEmpty == false }
		
		self.allLines = lines
		self.text = ""
	}
	
	func startUpdating() {
		guard updateTask == nil else { return }
		revealedCount = 0
		showNextState()
		
		updateTask = Task { [weak self] in
			while Task.isCancelled == false {
				let delay: Duration = .seconds(Int.random(in: 1...4))
				try? await Task.sleep(for: delay)
				
				guard Task.isCancelled == false, let self else { break }
				
				if allLines.isEmpty {
					revealedCount = 0
				} else {
					revealedCount = (revealedCount % allLines.count) + 1
				}
				
				showNextState()
			}
		}
	}
	
	func stopUpdating() {
		updateTask?.cancel()
		updateTask = nil
	}
	
	deinit {
		updateTask?.cancel()
	}
	
	private func showNextState() {
		if allLines.isEmpty {
			self.text = ""
		} else {
			let prefix = max(1, min(revealedCount, allLines.count))
			let visible = allLines.prefix(prefix).joined(separator: "\n")
			self.text = visible
		}
		onTextChanged?(self.text)
	}
}

