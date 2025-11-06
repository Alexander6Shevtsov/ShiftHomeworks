//
//  SceneDelegate.swift
//  ImageLoader
//
//  Created by Alexander Shevtsov on 03.11.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		let rootVC = ViewController()
		let navController = UINavigationController(rootViewController: rootVC)
		window.rootViewController = navController
		self.window = window
		window.makeKeyAndVisible()
	}
}
