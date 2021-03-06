//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 23/07/21.
//

import UIKit


protocol GFRepoItemVCDelegate: AnyObject {
	func didTapGitHubProfile(for user: User)
}


class GFRepoItemVC: GFItemInfoVC {
	weak var delegate: GFRepoItemVCDelegate!
	
	
	init(user: User, delegate: GFRepoItemVCDelegate) {
		super.init(user: user)
		
		self.delegate = delegate
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
		
	// MARK: - ViewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureItems()
	}
	
	
	// MARK: - Configuration Methods
	private func configureItems() {
		itemInfoViewOne.set(itemInfoType: .respos, withCount: user.publicRepos)
		itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
		
		actionButton.set(color: .systemPurple, title: LocalizedKeys.buttonsTitles.githubProfile, systemImageName: "person")
	}
	
	
	override func actionButtonTapped() {
		delegate.didTapGitHubProfile(for: user)
	}
}
