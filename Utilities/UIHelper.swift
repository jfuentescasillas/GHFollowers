//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 20/07/21.
//

import UIKit


struct UIHelper {
	static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minimumItemSpacing: CGFloat = 10
		let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)  // We do minimum spacing * 2 because in a 3 column layout, there are 2 spaces between the 3 items. The space between the left item and the middle item. And the space between the middle item and the right item.
		let itemWidth = availableWidth / 3
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
		
		return flowLayout
	}
}
