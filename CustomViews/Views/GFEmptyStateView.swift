//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 21/07/21.
//

import UIKit


class GFEmptyStateView: UIView {
	let messageLabel  = GFTitleLabel(textAlignment: .center, fontSize: 28)
	let logoImageView = UIImageView()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	convenience init(message: String) {
		self.init(frame: .zero)
		
		messageLabel.text = message
	}
	
	
	// MARK: - Configure Elements in view
	private func configure() {
		addSubviews(logoImageView, messageLabel)
		
		configureLogoImageView()
		configureMessageLabel()
	}
	
	
	private func configureLogoImageView() {		
		logoImageView.image = Images.emptyStateLogo
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		
		let logoImageViewTrailingConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 150 : 170
		
		NSLayoutConstraint.activate([
			logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: logoImageViewTrailingConstant),  // We want the image slightly to the right
			logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 50)  // We want the image slightly under the screen
		])
	}
	
	
	private func configureMessageLabel() {
		messageLabel.numberOfLines  = 4
		messageLabel.textColor		= .secondaryLabel
		
		let messageLabelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhoneSE2or3Gen ||
												   DeviceTypes.isiPhone8Zoomed ? -80 : -160
		
		NSLayoutConstraint.activate([
			messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: messageLabelCenterYConstant),
			messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
			messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
			messageLabel.heightAnchor.constraint(equalToConstant: 200)
		])
	}
}
