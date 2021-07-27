//
//  UIViewExt.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 22/07/21.
//

import UIKit


extension UIView {
	func addSubviews(_ subviews: UIView...) {  // ... stands for "variadic paramater" and we can add any number of views
		subviews.forEach { addSubview($0) }
	}
	
	
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
}
