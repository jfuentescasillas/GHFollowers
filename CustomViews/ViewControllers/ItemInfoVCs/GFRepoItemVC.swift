//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 23/07/21.
//

import UIKit


class GFRepoItemVC: GFItemInfoVC {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureItems()
	}
	
	
	private func configureItems() {
		itemInfoViewOne.set(itemInfoType: .respos, withCount: user.publicRepos)
		itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
		
		actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
	}
	
	
	override func actionButtonTapped() {
		delegate.didTapGitHubProfile(for: user)
	}
}
