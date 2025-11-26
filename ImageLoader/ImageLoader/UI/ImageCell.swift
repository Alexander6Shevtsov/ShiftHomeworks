//
//  ImageCell.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 05.11.2025.
//

import UIKit

final class ImageCell: UITableViewCell {
	
	private let pictureView = UIImageView()
	private let urlLabel = UILabel()
	private let progressView = UIProgressView(progressViewStyle: .default)
	private let percentLabel = UILabel()
	private let pauseButton = UIButton(type: .system)
	private let resumeButton = UIButton(type: .system)
	
	var onPause: (() -> Void)?
	var onResume: (() -> Void)?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with item: DownloadModel) {
		urlLabel.text = item.url.absoluteString
		
		pictureView.image = item.image
		
		progressView.progress = Float(item.progress)
		progressView.isHidden = item.state == .completed || item.state == .failed
		
		switch item.state {
		case .downloading, .queued:
			pauseButton.isHidden = false
			resumeButton.isHidden = true
		case .paused:
			pauseButton.isHidden = true
			resumeButton.isHidden = false
		case .completed, .failed:
			pauseButton.isHidden = true
			resumeButton.isHidden = true
		}
		
		if item.state == .failed {
			percentLabel.text = "Ошибка"
		} else if item.state == .completed {
			percentLabel.text = "100%"
		} else {
			let percent = Int((item.progress * 100).rounded())
			percentLabel.text = "\(percent)%"
		}
		
		selectionStyle = .none
	}
	
	private func setupViews() {
		pictureView.contentMode = .scaleAspectFit
		pictureView.clipsToBounds = true
		
		urlLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
		urlLabel.textColor = .label
		urlLabel.numberOfLines = 1
		urlLabel.lineBreakMode = .byTruncatingMiddle
		
		percentLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
		percentLabel.textColor = .secondaryLabel
		percentLabel.setContentHuggingPriority(.required, for: .horizontal)
		percentLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
		
		pauseButton.setTitle("Пауза", for: .normal)
		resumeButton.setTitle("Пуск", for: .normal)
		
		pauseButton.addTarget(self, action: #selector(tapPause), for: .touchUpInside)
		resumeButton.addTarget(self, action: #selector(tapResume), for: .touchUpInside)
		
		textLabel?.isHidden = true
		detailTextLabel?.isHidden = true
		
		contentView.addSubview(pictureView)
		contentView.addSubview(urlLabel)
		contentView.addSubview(progressView)
		contentView.addSubview(percentLabel)
		contentView.addSubview(pauseButton)
		contentView.addSubview(resumeButton)
		
		pictureView.translatesAutoresizingMaskIntoConstraints = false
		urlLabel.translatesAutoresizingMaskIntoConstraints = false
		progressView.translatesAutoresizingMaskIntoConstraints = false
		percentLabel.translatesAutoresizingMaskIntoConstraints = false
		pauseButton.translatesAutoresizingMaskIntoConstraints = false
		resumeButton.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupLayout() {
		NSLayoutConstraint.activate([
			pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			pictureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			pictureView.widthAnchor.constraint(equalToConstant: 60),
			pictureView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
			
			pauseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			resumeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			
			pauseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			resumeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			urlLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 12),
			urlLabel.trailingAnchor.constraint(lessThanOrEqualTo: pauseButton.leadingAnchor, constant: -12),
			urlLabel.trailingAnchor.constraint(lessThanOrEqualTo: resumeButton.leadingAnchor, constant: -12),
			urlLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			
			progressView.leadingAnchor.constraint(equalTo: urlLabel.leadingAnchor),
			progressView.trailingAnchor.constraint(equalTo: urlLabel.trailingAnchor),
			progressView.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 8),
			
			percentLabel.leadingAnchor.constraint(greaterThanOrEqualTo: progressView.trailingAnchor, constant: 8),
			percentLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
			percentLabel.trailingAnchor.constraint(lessThanOrEqualTo: pauseButton.leadingAnchor, constant: -12),
			percentLabel.trailingAnchor.constraint(lessThanOrEqualTo: resumeButton.leadingAnchor, constant: -12),
			
			progressView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
		])
	}
	
	@objc private func tapPause() {
		onPause?()
	}
	
	@objc private func tapResume() {
		onResume?()
	}
}

