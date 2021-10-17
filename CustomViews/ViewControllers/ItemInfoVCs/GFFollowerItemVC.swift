//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 23/07/21.
//

import UIKit


protocol GFFollowerItemVCDelegate: AnyObject {
	func didTapGetFollowers(for user: User)
}


class GFFollowerItemVC: GFItemInfoVC {
	weak var delegate: GFFollowerItemVCDelegate!
	
	
	init(user: User, delegate: GFFollowerItemVCDelegate) {
		super.init(user: user)
		
		self.delegate = delegate
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureItems()
	}
	
	
	private func configureItems() {
		itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
		itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
		
		actionButton.set(color: .systemGreen, title: LocalizedKeys.buttonsTitles.getFollowers, systemImageName: "person.3")
	}
	
	
	override func actionButtonTapped() {
		delegate.didTapGetFollowers(for: user)
	}
}
