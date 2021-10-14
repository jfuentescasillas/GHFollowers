//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 25/07/21.
//

import UIKit


class FavoriteCell: UITableViewCell {
	// MARK: - Properties
	static let reuseID: String = "favoriteCell"
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel 	= GFTitleLabel(textAlignment: .center, fontSize: 26)
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func configure() {
		addSubviews(avatarImageView, usernameLabel)
		
		accessoryType 			= .disclosureIndicator
		let padding: CGFloat 	= 12
		
		NSLayoutConstraint.activate([
			avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			avatarImageView.heightAnchor.constraint(equalToConstant: 60),
			avatarImageView.widthAnchor.constraint(equalToConstant: 60),
			
			usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
			usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 40)
		])
	}
	
	
	func set(favorite: Follower) {
		avatarImageView.downloadImage(fromURL: favorite.avatarUrl)
		usernameLabel.text = favorite.login
	}
}
