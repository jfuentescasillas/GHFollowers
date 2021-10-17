//
//  GFButton.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 07/07/21.
//

import UIKit

class GFButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	convenience init(color: UIColor, title: String, systemImageName: String) {
		self.init(frame: .zero)
		
		/*self.backgroundColor = backgroundColor
		self.setTitle(title, for: .normal)*/
		set(color: color, title: title, systemImageName: systemImageName)
	}
	
	
	private func configure() {
		// This is the basic configuration that each button must have
		configuration = .filled()
		configuration?.cornerStyle = .medium
		translatesAutoresizingMaskIntoConstraints = false
		
		/*layer.cornerRadius 	= 10
		titleLabel?.font 	= UIFont.preferredFont(forTextStyle: .headline)
		setTitleColor(.white, for: .normal)  // Change title's */
	}
	
	
	func set(color: UIColor, title: String, systemImageName: String) {
		configuration?.baseBackgroundColor = color
		configuration?.baseForegroundColor = .white
		configuration?.title = title
		
		configuration?.image = UIImage(systemName: systemImageName)
		configuration?.imagePadding = 6
		configuration?.imagePlacement = .leading
		/*self.backgroundColor = color
		setTitle(title, for: .normal)*/
	}
}
