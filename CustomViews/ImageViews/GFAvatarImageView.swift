//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 19/07/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
	let cache 			 = NetworkManager.shared.cache
	let placeholderImage = Images.avatarPlaceholder
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func configure() {
		layer.cornerRadius 	= 10
		clipsToBounds 		= true
		image 				= placeholderImage
		translatesAutoresizingMaskIntoConstraints = false
	}
}
