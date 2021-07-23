//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 21/07/21.
//

import UIKit


protocol UserInfoVCDelegate: AnyObject {
	func didTapGitHubProfile(for user: User)
	func didTapGetFollowers(for user: User)
}


class UserInfoVC: UIViewController {
	let headerView 	= UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	let dateLabel	= GFBodyLabel(textAlignment: .center)
	var itemViews 	= [UIView]()
	
	var username: String!
	weak var delegate: FollowersListVCDelegate!

	
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
				DispatchQueue.main.async { self.configureUIElements(with: user) }
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something Went Wrong",
												message: error.rawValue,
												buttonTitle: "OK")
			}
		}
	}
	
	
	func configureUIElements(with user: User) {
		let repoItemVC 			= GFRepoItemVC(user: user)
		repoItemVC.delegate 	= self
		
		let followerItemVC 		= GFFollowerItemVC(user: user)
		followerItemVC.delegate = self
		
		self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.addChildVC(childVC: repoItemVC, to: self.itemViewOne)
		self.addChildVC(childVC: followerItemVC, to: self.itemViewTwo)
		self.dateLabel.text = "In GitHub since \(user.createdAt.convertToDisplayFormat())"	
	}
	
	
	// MARK: - LayoutUI
	private func layoutUI() {
		itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
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
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 180),
			
			itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			
			itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
			itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			
			dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 18),
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


// MARK: - Extension UserInfoVCDelegate
extension UserInfoVC: UserInfoVCDelegate {
	func didTapGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainThread(title: "Invalid URL",
									   message: "Invalid URL attached to this user",
									   buttonTitle: "OK")
			
			return
		}
		
		presentSafariVC(with: url)
	}
	
	
	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			presentGFAlertOnMainThread(title: "No Followers",
									   message: "This User Has NO Followers",
									   buttonTitle: "Sad Life ☹️")
			
			return
		}
		
		delegate.didRequestFollowers(for: user.login)
		dismissVC()
	}
}
