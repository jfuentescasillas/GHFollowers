//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 08/07/21.
//

import UIKit


class GFAlertVC: UIViewController {
	// Properties
	let containerView 	 = GFAlertContainerView()
	let titleLabel 		 = GFTitleLabel(textAlignment: .center, fontSize: 20)
	let messageLabel 	 = GFBodyLabel(textAlignment: .center)
	let actionButton 	 = GFButton(backgroundColor: .systemPink, title: "OK")
	let padding: CGFloat = 20
	
	var alertTitle: String?
	var message: String?
	var buttonTitle: String?
	
	
	init(title: String, message: String, buttonTitle: String) {
		super.init(nibName: nil, bundle: nil)
		
		self.alertTitle 	= title
		self.message 		= message
		self.buttonTitle 	= buttonTitle
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

	// MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

		view.addSubview(containerView)
		view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
		
		containerView.addSubviews(titleLabel, actionButton, messageLabel)

		configureContainerView()
		configureTitleLabel()
		configureActionButton()
		configureMessageLabel()
    }
	
	
	// MARK: - Config
	func configureContainerView() {
		NSLayoutConstraint.activate([
			containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			containerView.widthAnchor.constraint(equalToConstant: 280),
			containerView.heightAnchor.constraint(equalToConstant: 220)
		])
	}
	
	
	func configureTitleLabel() {
		titleLabel.text = alertTitle ?? LocalizedKeys.alertControllerDefaultTitles.somethingWentWrongDefault
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			titleLabel.heightAnchor.constraint(equalToConstant: 28)
		])
	}
	
	
	func configureActionButton() {
		actionButton.setTitle(buttonTitle ?? LocalizedKeys.alertControllerButtonTitle.okButtonTitle, for: .normal)
		actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)		
		
		NSLayoutConstraint.activate([
			actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
	
	
	@objc func dismissVC() {
		dismiss(animated: true)
	}
	
	
	func configureMessageLabel() {
		messageLabel.text = message ?? LocalizedKeys.alertControllerErrorMessages.unableToCompleteRequest
		messageLabel.numberOfLines = 4
		
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
		])
	}
}
