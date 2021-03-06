//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 19/07/21.
//

import UIKit


class FollowerCell: UICollectionViewCell {
	// MARK: - Properties
	static let reuseID: String = "followerCell"
    
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel 	= GFTitleLabel(textAlignment: .center, fontSize: 16)
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func set(follower: Follower) {
		avatarImageView.downloadImage(fromURL: follower.avatarUrl)
		usernameLabel.text = follower.login
	}
	
	
	private func configure() {
		addSubviews(avatarImageView, usernameLabel)
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
			usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
		])
	}
}
