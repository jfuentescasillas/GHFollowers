//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 21/07/21.
//

import UIKit


protocol UserInfoVCDelegate: AnyObject {
	func didRequestFollowers(for username: String)
}


class UserInfoVC: GFDataLoadingVC {
	let scrollView	= UIScrollView()
	let contentView = UIView()
	
	let headerView 	= UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	let dateLabel	= GFBodyLabel(textAlignment: .center)
	var itemViews 	= [UIView]()
	
	var username: String!
	weak var delegate: UserInfoVCDelegate!

	
	// MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
		
		doneButtonConfiguration()
		configureScrollView()
		layoutUI()
		getUserInfo()
    }
	
	
	// MARK: - DoneButton methods
	private func doneButtonConfiguration() {
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
				self.presentGFAlertOnMainThread(title: LocalizedKeys.alertControllerDefaultTitles.somethingWentWrongDefault,
												message: error.rawValue,
												buttonTitle: LocalizedKeys.alertControllerButtonTitle.okButtonTitle)
			}
		}
	}
	
	
	// MARK: - Configure UI Elements Methods
	func configureUIElements(with user: User) {
		self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.addChildVC(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
		self.addChildVC(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
		self.dateLabel.text = LocalizedKeys.labelsContent.inGithubSinceLbl +  user.createdAt.convertToMonthYearFormat()
	}
	
	
	func configureScrollView() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		scrollView.pinToEdges(of: view)
		contentView.pinToEdges(of: scrollView)
		
		NSLayoutConstraint.activate([
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: view.frame.size.height + 25 )  // If "+ 25" is not added, the date label is out of screen on iPhone SE 1st Gen.
			//contentView.heightAnchor.constraint(equalToConstant: 600)
		])
	}
	
	
	// MARK: - LayoutUI
	private func layoutUI() {
		let padding: CGFloat 	= 20
		let itemHeight: CGFloat = 140
		
		itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
		
		for itemView in itemViews {
			contentView.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			])
		}
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 210),
			
			itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			
			itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
			itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			
			dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 50),
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


// MARK: - Extension GFRepoItemVCDelegate and GFFollowerItemVCDelegate
extension UserInfoVC: GFRepoItemVCDelegate {
	func didTapGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainThread(title: LocalizedKeys.alertControllerDefaultTitles.invalidURLTitle,
									   message: LocalizedKeys.alertControllerMessages.invalidURLMsg,
									   buttonTitle: LocalizedKeys.alertControllerButtonTitle.okButtonTitle)
			
			return
		}
		
		presentSafariVC(with: url)
	}
}


extension UserInfoVC: GFFollowerItemVCDelegate {
	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			presentGFAlertOnMainThread(title: LocalizedKeys.alertControllerDefaultTitles.noFollowersTitle,
									   message: LocalizedKeys.alertControllerMessages.noFollowersMsg,
									   buttonTitle: LocalizedKeys.alertControllerButtonTitle.sadButtonTitle)
			
			return
		}
		
		delegate.didRequestFollowers(for: user.login)
		dismissVC()
	}
}
