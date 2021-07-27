//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 26/07/21.
//

import UIKit


class GFAlertContainerView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func configure() {
		backgroundColor = .systemBackground
		layer.cornerRadius = 16
		layer.borderWidth = 2	 // This is to make it noticeable on dark mode
		layer.borderColor = UIColor.white.cgColor
		translatesAutoresizingMaskIntoConstraints = false
	}
}
