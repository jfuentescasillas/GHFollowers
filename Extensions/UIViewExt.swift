//
//  UIViewExt.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 22/07/21.
//

import UIKit


extension UIView {
	func addSubviews(_ subviews: UIView...) {
		subviews.forEach { addSubview($0) }
	}
}
