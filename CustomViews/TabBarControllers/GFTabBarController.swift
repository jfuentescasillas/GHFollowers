//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 26/07/21.
//

import UIKit


class GFTabBarController: UITabBarController {

	
    override func viewDidLoad() {
        super.viewDidLoad()

		initialConfig()
    }
	
	
	// MARK: - Initial Configuration
	private func initialConfig() {
		UITabBar.appearance().tintColor = .systemGreen
		viewControllers 				= [createSearchNavContr(), createFavoritesNavController()]
	}
    

	// MARK: - Create Navigation Controller Methods
	private func createSearchNavContr() -> UINavigationController {
		let searchVC 		= SearchVC()
		searchVC.title 		= "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		
		return UINavigationController(rootViewController: searchVC)
	}
	
	
	private func createFavoritesNavController() -> UINavigationController {
		let favoritesListVC 		= FavoriteListVC()
		favoritesListVC.title 		= "Favorites"
		favoritesListVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		
		return UINavigationController(rootViewController: favoritesListVC)
	}
}
