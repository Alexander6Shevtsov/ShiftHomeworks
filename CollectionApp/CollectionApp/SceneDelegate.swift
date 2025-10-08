//
//  SceneDelegate.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 08.10.2025.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		let root = CatalogViewController()
		let navigation = UINavigationController(rootViewController: root)
		window.rootViewController = navigation
		window.makeKeyAndVisible()
		self.window = window
	}
}
