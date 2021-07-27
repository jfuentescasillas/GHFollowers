//
//  UIViewControllerExt.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 08/07/21.
//

import UIKit
import SafariServices


extension UIViewController {
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			
			self.present(alertVC, animated: true)
		}
	}
	
	
	// MARK: - Present SafariVC
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor = .systemGreen
		present(safariVC, animated: true)
	}
}
