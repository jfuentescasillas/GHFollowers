//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 07/07/21.
//

import UIKit


class FollowersListVC: UIViewController {
	// MARK: - Properties
	var username: String!
	

	// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		
		NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
			guard let followers = followers else {
				self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: errorMessage!.rawValue, buttonTitle: "OK")
				
				return
			}
			
			print("Followers.count = \(followers.count)")
			print("Followers = \(followers)")
		}
    }
	
	
	// MARK: - viewWillAppear
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		 
		// Moving this line of code to viewWill Appear deals with a bug in which the NavigationBar was involved (it showed when it was not supposed to appear)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
}
