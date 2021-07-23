//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 21/07/21.
//

import UIKit


class UserInfoVC: UIViewController {
	let headerView 	= UIView()
	let itemOneView = UIView()
	let itemTwoView = UIView()
	var username: String!
	var itemViews 	= [UIView]()

	
	// MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
		
		doneButton()
		layoutUI()
		getUserInfo()
    }
	
	
	// MARK: - DoneButton methods
	private func doneButton() {
		view.backgroundColor = .systemBackground  // QUITAR****
		
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
				DispatchQueue.main.async {
					self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
				}
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something Went Wrong",
												message: error.rawValue,
												buttonTitle: "OK")
			}
		}
	}
	
	
	// MARK: - LayoutUI
	private func layoutUI() {
		itemViews = [headerView, itemOneView, itemTwoView]
		let padding: CGFloat 	= 20
		let itemHeight: CGFloat = 140
		
		for itemView in itemViews {
			view.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			])
		}
				
		itemOneView.backgroundColor = .systemPink
		itemTwoView.backgroundColor = .systemGreen
		
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 180),
			
			itemOneView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemOneView.heightAnchor.constraint(equalToConstant: itemHeight),
			
			itemTwoView.topAnchor.constraint(equalTo: itemOneView.bottomAnchor, constant: padding),
			itemTwoView.heightAnchor.constraint(equalToConstant: itemHeight),
		])
	}
	
	
	// MARK: - AddChildVC
	func addChildVC(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}
}
