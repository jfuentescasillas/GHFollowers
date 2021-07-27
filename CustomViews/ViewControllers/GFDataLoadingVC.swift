//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 26/07/21.
//

import UIKit

class GFDataLoadingVC: UIViewController {
	// MARK: - Properties
	var containerView: UIView!

    
	// MARK: - Show and Dismiss Loading view
	func showLoadingView() {
		containerView = UIView(frame: view.bounds)
		view.addSubview(containerView)
		
		containerView.backgroundColor 	= .systemBackground
		containerView.alpha 			= 0
		
		UIView.animate(withDuration: 0.3) { self.containerView.alpha = 0.75 }
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
		])
		
		activityIndicator.startAnimating()
	}
	
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			self.containerView.removeFromSuperview()
			self.containerView = nil
		}
	}
	
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptyStateView 				= GFEmptyStateView(message: message)
		emptyStateView.frame 			= view.bounds
		emptyStateView.backgroundColor 	= .systemBackground
		view.addSubview(emptyStateView)
	}	 
}
