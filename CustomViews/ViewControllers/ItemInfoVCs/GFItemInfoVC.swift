//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 23/07/21.
//
//  Generic Super Class for other views

import UIKit


protocol GFItemInfoVCDelegate: AnyObject {
	func didTapGitHubProfile(for user: User)
	func didTapGetFollowers(for user: User)
}


class GFItemInfoVC: UIViewController {
	// MARK: - Properties
	let stackView		= UIStackView()
	let itemInfoViewOne = GFItemInfoView()  // Goes Inside the StackView
	let itemInfoViewTwo = GFItemInfoView()  // Goes Inside the StackView
	let actionButton	= GFButton()
	
	var user: User!
	

	// MARK: - Initializers
	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		
		self.user = user
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureBackgroundView()
		configureActionButton()
		layoutUI()
		configureStackView()
    }
	
	
	// MARK: - Configure background method
	private func configureBackgroundView() {
		view.layer.cornerRadius = 18
		view.backgroundColor	= .secondarySystemBackground
	}
	
	
	// MARK: - Layout UI method
	private func layoutUI() {
		view.addSubviews(stackView, actionButton)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		let padding: CGFloat = 20
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			stackView.heightAnchor.constraint(equalToConstant: 50),
			
			actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44),
		])
	}
	
	
	// MARK: - configure Stack view
	private func configureStackView() {
		stackView.axis 			= .horizontal
		stackView.distribution 	= .equalSpacing
		
		stackView.addArrangedSubview(itemInfoViewOne)
		stackView.addArrangedSubview(itemInfoViewTwo)
	}
	
	
	// MARK: - Action Button
	private func configureActionButton() {
		actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
	}
	
	
	@objc func actionButtonTapped() {}
}
