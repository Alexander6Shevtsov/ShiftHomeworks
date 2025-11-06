//
//  AppDelegate.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 03.11.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var backgroundSessionCompletionHandler: (() -> Void)?
	
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool { return true }
		
	func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		return UISceneConfiguration(
			name: "Default Configuration",
			sessionRole: connectingSceneSession.role
		)
	}
	
	func application(
		_ application: UIApplication,
		handleEventsForBackgroundURLSession identifier: String,
		completionHandler: @escaping () -> Void
	) {
		backgroundSessionCompletionHandler = completionHandler
		
		DownloadManager.shared.backgroundSessionCompletionHandler = completionHandler
	}
}
