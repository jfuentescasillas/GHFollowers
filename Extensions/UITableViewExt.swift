//
//  UITableViewExt.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 27/07/21.
//

import UIKit


extension UITableView {
	func reloadDataOnMainThread() {
		DispatchQueue.main.async { self.reloadData() }
	}
	
	
	func removeExcessCells() {
		tableFooterView = UIView(frame: .zero)
	}
}
