//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 22/07/21.
//

import UIKit


enum ItemInfoType {
	case respos, gists, followers, following
}


class GFItemInfoView: UIView {
	let symbolImageView = UIImageView()
	let titleLabel 		= GFTitleLabel(textAlignment: .left, fontSize: 14)
	let countLabel 		= GFTitleLabel(textAlignment: .center, fontSize: 14)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Configure()
	private func configure() {
		addSubviews(symbolImageView, titleLabel, countLabel)
		
		symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		symbolImageView.contentMode = .scaleAspectFill
		symbolImageView.tintColor 	= .label
		
		NSLayoutConstraint.activate([
			symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
			symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			symbolImageView.widthAnchor.constraint(equalToConstant: 20),
			symbolImageView.heightAnchor.constraint(equalToConstant: 20),									 // BORRAR ALTURA??
			
			titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			titleLabel.heightAnchor.constraint(equalToConstant: 18),									  	// BORRAR ALTURA??
			
			countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
			countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			countLabel.heightAnchor.constraint(equalToConstant: 18)									  		// BORRAR ALTURA??
		])
	}
	
	
	func set(itemInfoType: ItemInfoType, withCount count: Int) {
		switch itemInfoType {
		case .respos:
			symbolImageView.image 	= UIImage(systemName: SFSymbols.repos)
			titleLabel.text 	  	= "Public Repos"
			
		case .gists:
			symbolImageView.image = UIImage(systemName: SFSymbols.gists)
			titleLabel.text 	  = "Public Gists"
			
		case .followers:
			symbolImageView.image = UIImage(systemName: SFSymbols.followers)
			titleLabel.text 	  = "Followers"
		
		case .following:
			symbolImageView.image = UIImage(systemName: SFSymbols.following)
			titleLabel.text 	  = "Following"
		}
		
		countLabel.text = String(count)
	}
}