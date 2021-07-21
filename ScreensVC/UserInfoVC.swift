//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 21/07/21.
//

import UIKit


class UserInfoVC: UIViewController {
	var username: String!

	
	// MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
		
		doneButton()
		getUserInfo()
    }
	
	
	// MARK: - DoneButton methods
	private func doneButton() {
		view.backgroundColor = .systemBackground  // QUITAR****
		
		print(username!)
		
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItem = doneButton
	}
	
	
	@objc func dismissVC() {
		dismiss(animated: true)
	}
	
	
	// MARK: - GetUserInfo
	func getUserInfo() {
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let user):
				print(user)
			
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something Went Wrong",
												message: error.rawValue,
												buttonTitle: "OK")
			}
		}
	}
}
