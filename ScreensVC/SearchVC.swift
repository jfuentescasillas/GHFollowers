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
	let callToActionButton 	= GFButton(color: .systemGreen, title: LocalizedKeys.buttonsTitles.getFollowers, systemImageName: "person.3")
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
		let vPadding: CGFloat = 45  // Vertical padding (top/bottom/height constraints)
		let hPadding: CGFloat = 30 // Horizontal padding (leading/trailing constraints)
		
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: vPadding),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: hPadding),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -hPadding),
			usernameTextField.heightAnchor.constraint(equalToConstant: vPadding)
		])
	}
	
	
	func configureCallToActionButton() {
		let vPadding: CGFloat = 45
		let hPadding: CGFloat = 30
		
		callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -vPadding),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: hPadding),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -hPadding),
			callToActionButton.heightAnchor.constraint(equalToConstant: vPadding)
		])
	}
	
	
	@objc func pushFollowersListVC() {
		guard isUsernameEntered else {
			presentGFAlert(title: LocalizedKeys.alertControllerDefaultTitles.emptyUsernameTitle,
									   message: LocalizedKeys.alertControllerMessages.emptyUsernameMsg,
									   buttonTitle: LocalizedKeys.alertControllerButtonTitle.okButtonTitle)
			
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
