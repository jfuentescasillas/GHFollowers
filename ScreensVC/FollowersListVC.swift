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
	
	
	// MARK: - viewWillAppear
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		 
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	

	// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
    }
}
