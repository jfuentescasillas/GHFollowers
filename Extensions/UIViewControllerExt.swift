//
//  UIViewControllerExt.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 08/07/21.
//

import UIKit
import SafariServices


fileprivate var containerView: UIView!


extension UIViewController {
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			
			self.present(alertVC, animated: true)
		}
	}
	
	
	// MARK: - Show and Dismiss Loading view
	func showLoadingView() {
		containerView = UIView(frame: view.bounds)
		view.addSubview(containerView)
		
		containerView.backgroundColor 	= .systemBackground
		containerView.alpha 			= 0
		
		UIView.animate(withDuration: 0.3) { containerView.alpha = 0.75 }
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		activityIndicator.startAnimating()
	}
	
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			containerView.removeFromSuperview()
			containerView = nil
		}
	}
	
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptyStateView 				= GFEmptyStateView(message: message)
		emptyStateView.frame 			= view.bounds
		emptyStateView.backgroundColor 	= .systemBackground
		view.addSubview(emptyStateView)
	}
	
	
	// MARK: - Present SafariVC
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor = .systemGreen
		present(safariVC, animated: true)
	}
}
