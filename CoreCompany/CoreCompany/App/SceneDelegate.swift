//
//  SceneDelegate.swift
//  CoreCompany
//
//  Created by Alexander Shevtsov on 07.11.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		self.window = window
		let companies = CompaniesViewController()
		let navigationController = UINavigationController(rootViewController: companies)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}

