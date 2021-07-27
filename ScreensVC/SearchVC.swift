//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 06/07/21.
//

import UIKit


class SearchVC: UIViewController {
	// MARK: - Properties
	let logoImageView 		= UIImageView()
	let usernameTextField 	= GFTextField()
	let callToActionButton 	= GFButton(backgroundColor: .systemGreen, title: "Get Followers")
	var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
	
	
	// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		view.addSubviews(logoImageView, usernameTextField, callToActionButton)
		
		configureLogoImageView()
		configureTextField()
		configureCallToActionButton()
		createDismissKeyboardTapGesture()
    }
	
	
	// MARK: - viewWillAppear
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		usernameTextField.text = ""
		
		// Moving the line of code below to viewWill Appear deals with a bug in which the NavigationBar was involved (it disappeard when it supposed to appear)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	

	// MARK: - Methods to Configure the Elements in the view
	func configureLogoImageView() {
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = Images.ghLogo
		
		let logoImageViewTopConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
				
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: logoImageViewTopConstraintConstant),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	
	func configureTextField() {
		usernameTextField.delegate = self
		
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			usernameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	
	func configureCallToActionButton() {
		callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			callToActionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	
	@objc func pushFollowersListVC() {
		guard isUsernameEntered else {
			presentGFAlertOnMainThread(title: "Empty Username",
									   message: "Please enter a username, we need to know who to look for",
									   buttonTitle: "OK")
			
			return
		}
		
		usernameTextField.resignFirstResponder()
		
		let followersListVC = FollowersListVC(username: usernameTextField.text!)		
		navigationController?.pushViewController(followersListVC, animated: true)
	}
	
	
	// MARK: - Methods to Dismiss keyboard from screen
	func createDismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
		view.addGestureRecognizer(tap)
	}
}


// MARK: - Extension: Textfield Delegate
extension SearchVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pushFollowersListVC()
		
		return true
	}
}
