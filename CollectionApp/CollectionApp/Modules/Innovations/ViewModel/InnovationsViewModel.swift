//
//  InnovationsViewModel.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 17.10.2025.
//

import Foundation

@MainActor
final class InnovationsViewModel {
	
	private let allLines: [String]
	
	private(set) var text: String
	
	var onTextChanged: ((String) -> Void)?
	
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
				let delay = UInt64(Int.random(in: 1...4)) * 1_000_000_000
				try? await Task.sleep(nanoseconds: delay)
				
				guard Task.isCancelled == false, let self else { break }
				
				if revealedCount < allLines.count {
					revealedCount += 1
				} else {
					revealedCount = 1
				}
				
				showNextState()
			}
		}
	}
	
	func stopUpdating() {
		updateTask?.cancel()
		updateTask = nil
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
