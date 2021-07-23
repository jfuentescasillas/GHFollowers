//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 22/07/21.
//

import UIKit


class GFSecondaryTitleLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	init(fontSize: CGFloat) {
		super.init(frame: .zero)
		
		font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
		
		configure()
	}
	
	
	private func configure() {
		textColor 					= .secondaryLabel
		font 						= UIFont.preferredFont(forTextStyle: .body)
		adjustsFontSizeToFitWidth	= true
		minimumScaleFactor 			= 0.9
		lineBreakMode 				= .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
}
