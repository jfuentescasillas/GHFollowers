//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 23/07/21.
//

import UIKit


class GFFollowerItemVC: GFItemInfoVC {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureItems()
	}
	
	
	private func configureItems() {
		itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
		itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
		
		actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
	}
	
	
	override func actionButtonTapped() {
		delegate.didTapGetFollowers(for: user)
	}
}
