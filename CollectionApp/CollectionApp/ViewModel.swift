//
//  InnovationsViewModel.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 17.10.2025.
//

import Foundation

protocol InnovationsViewModeling: AnyObject {
	var text: String { get }
	var onTextUpdate: ((String) -> Void)? { get set }

	func viewDidLoad()
	func stop()
}

@MainActor
final class InnovationsViewModel: InnovationsViewModeling {

	private let baseText: String
	private var counter = 0
	private var updateTask: Task<Void, Never>?

	private(set) var text: String
	var onTextUpdate: ((String) -> Void)?

	init(featuresText: String) {
		self.baseText = featuresText
		self.text = featuresText
	}

	func viewDidLoad() {
		startUpdating()
	}

	func stop() {
		updateTask?.cancel()
		updateTask = nil
	}

	deinit {
		updateTask?.cancel()
	}

	private func startUpdating() {
		guard updateTask == nil else { return }

		updateTask = Task { [weak self] in
			guard let self else { return }
			while !Task.isCancelled {
				let delayMillis = UInt64(Double.random(in: 1.5...4.0) * 1_000)
				try? await Task.sleep(nanoseconds: delayMillis * 1_000_000)

				counter += 1
				let updated = "\(baseText)\n\nОбновлено: #\(counter)"

				self.text = updated
				self.onTextUpdate?(updated)
			}
		}
	}
}
